import nexmo
import urllib3
import secrets

import os
import time
import json

from flask import Blueprint, Response, abort, g, jsonify
from flask_httpauth import HTTPTokenAuth
from flask_restful import Api, Resource, reqparse, request

from .models import User

auth_ = HTTPTokenAuth(scheme="Bearer")

user_app = Blueprint('user_app', __name__)
api = Api(user_app)
basedir = os.path.abspath(os.path.dirname(__file__))


class SignupAPI(Resource):
    model = User
    userParser = reqparse.RequestParser()
    userParser.add_argument('full_name', type=str, nullable=False)
    userParser.add_argument('email', type=str, nullable=False)
    userParser.add_argument('phone_number', type=str, nullable=False)
    userParser.add_argument('password', type=str, nullable=False)

    def get(self):
        print('getting....')
        return {"msg": "Creates new user",
                "fields": "value types",
                "full_name": "string",
                "email": "string",
                "phone_number": "string",
                "password": "string",
                }

    def post(self):
        """
        Creates new user
        Parameters:
            -full_name (str)
            -email (str)
            -phone_number (str)
            -password (str)
        """
        # TODO: return all errors as message
        # time.sleep(1.5)
        args = self.userParser.parse_args()
        print(args)
        args = {field: value.strip() for field, value in args.items() if value}
        # TODO: Add validations to args,
        if len(args) < 4:
            abort(400, "Some Parameter(s) are missing")
        user = self.model.create_user(full_name=args['full_name'],
                                      email=args['email'],
                                      phone_number=args['phone_number'],
                                      password=args['password'])
        if not user:
            abort(409, "account found on platform, create_user unsuccessful.")
        g.user = user
        # auth_token = user.generate_auth_token()
        uid = secrets.token_hex(10)
        return {'status': 'success',
                'message': 'Account Created, proceed to home',
                'user': user.profile(),
                }


class GetCode(Resource):
    verification_Parser = reqparse.RequestParser()
    verification_Parser.add_argument('phone_number', type=str, nullable=False)

    # print(os.path.join(basedir))
    with open(f"{basedir}/nexmo_cred.json") as credentials:
        cred = json.load(credentials)
        key = cred["key"]
        secret = cred["secret"]
    nexmo_client = nexmo.Client(key=key, secret=secret)

    def post(self):
        phone_number = self.verification_Parser.parse_args()['phone_number']

        if not phone_number:
            return {"status": "attach phone_number to verify 234xxxxxxxxxx"}
        if phone_number[0] == "0":
            phone_number = f"234{phone_number[1:]}"
            print(phone_number, type(phone_number))
        response = self.nexmo_client.start_verification(
            number=phone_number,
            brand="TradIn",
            workflow_id="5",
            code_length="4")
        print(phone_number)
        result = {"status": "Started verification",
                  "request_id": response["request_id"]} \
            if response["status"] == "0" \
            else {"status": "Error: %s" % response["error_text"]}
        return result


class VerifyPhone(Resource):
    verification_Parser = reqparse.RequestParser()
    verification_Parser.add_argument('phone_number', type=str, nullable=False)
    verification_Parser.add_argument('code', type=str, nullable=False)
    verification_Parser.add_argument('request_id', type=str, nullable=False)

    # print(os.path.join(basedir))
    with open(f"{basedir}/nexmo_cred.json") as credentials:
        cred = json.load(credentials)
        key = cred["key"]
        secret = cred["secret"]
    nexmo_client = nexmo.Client(key=key, secret=secret)

    @auth_.login_required
    def post(self):
        args = self.verification_Parser.parse_args()
        request_id, code = args['request_id'], args['code']
        response = self.nexmo_client.check_verification(request_id, code=code)
        if response["status"] == "0":
            g.user.phone_verified()
            result = {"status": "Verificaton Successful",
                      "user": g.user.profile(), }
        else:
            result = {"status": "Error: %s" % response["error_text"]}
        print(g.user)
        print(result)
        return result


class LoginAPI(Resource):
    model = User
    userParser = reqparse.RequestParser()
    userParser.add_argument('identity', type=str, nullable=False)
    userParser.add_argument('password', type=str, nullable=False)

    def get(self):
        return {"msg": "Post [PHONE/Email] and [PASSWORD] to get token"}

    def post(self):
        args = self.userParser.parse_args()
        response_object = {'status': 'Failed',
                           'message': 'Incorrect phone_number or password'}
        identity, password = args['identity'], args['password']
        user, auth_token = self.model.login(identity, password)
        # uid = secrets.token_hex(10)
        if user:
            response_object = {'status': 'Success',
                               'message': 'Login successful',
                               'user': user.profile(),
                               }
        g.user = user
        return jsonify(response_object)


class Home(Resource):
    @auth_.login_required
    def get(self):
        return {"msg": "@Home_page",
                "user": g.user.profile()}


class Profile(Resource):
    model = User
    userParser = reqparse.RequestParser()
    userParser.add_argument('identity', type=str, nullable=False)

    @auth_.login_required
    def post(self):
        identity = self.userParser.parse_args()['identity']
        user = self.model.check_user(phone_number=identity, email=identity)
        if user:
            return user.profile()
        else:
            abort(404, ("userNotFound"))


@auth_.verify_token
def verify_token(token):
    user = User.verify_auth_token(token)
    if not user:
        abort(400, {"error": "Invalid token"})
    g.user = user
    return True

# def get_auth_token():
#         token = g.user.generate_auth_token()
#         return jsonify({'token': token})


api.add_resource(SignupAPI, '/create_user/')
api.add_resource(LoginAPI, '/login/')
api.add_resource(VerifyPhone, '/verify_phone/')
api.add_resource(GetCode, '/get_code/')
api.add_resource(Profile, '/profile/')
api.add_resource(Home, '/')
