import secrets
import time

from flask import Blueprint, Response, abort, g, jsonify

from flask_httpauth import HTTPTokenAuth
from flask_restful import Api, Resource, reqparse, request

from .models import User

auth_ = HTTPTokenAuth(scheme="Bearer")

user_app = Blueprint('user_app', __name__)
api = Api(user_app)

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
        args = {field: value.strip() for field, value in args.items() if value}
        # TODO: Add validations to args,
        if len(args) < 5:
            abort(400, "Some Parameter(s) are missing")
        user = self.model.create_user(full_name=args['full_name'],
                                      email=args['email'],
                                      phone_number=args['phone_number'],
                                      password=args['password'])
        if not user:
            abort(409, "account found on platform, create_user unsuccessful.")
        g.user = user
        auth_token = user.generate_auth_token()
        current_time = time.time()
        uid = secrets.token_hex(10)
        return {'status': 'success',
                'message': 'Account Created, proceed to home',
                'user': {
                    'providerData': [
                        {'providerId': 'self',
                         'uid': uid,
                         'displayName': 'VICTOR ADEYANJU',
                         'photoUrl': 'user.photo_url',
                         'email': 'user.email',
                         'phoneNumber': 'user.phone_number',
                         'isEmailVerified': 'user.is_email_verified()',
                         'isPhoneVerified': 'user.is_phone_number_verified()',
                         },
                    ],
                },
                'token': 'auth_token',
                }


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
        if user:
            response_object = {'status': 'Success',
                               'message': 'Login successful', 'token': auth_token}
        g.user = user
        return jsonify(response_object)


class Home(Resource):

    @auth_.login_required
    def get(self):
        return {"msg": "@Home_page"}


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
api.add_resource(Home, '/')
