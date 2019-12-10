from flask import current_app
from flask_login import UserMixin
from werkzeug.security import check_password_hash, generate_password_hash
from itsdangerous import (
    TimedJSONWebSignatureSerializer as Serializer, BadSignature, SignatureExpired)
from . import db, ma, login_manager


class User(UserMixin, db.Model):
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key=True)
    full_name = db.Column("firstName", db.String(50), nullable=False)
    email = db.Column("email", db.String(50), index=True, unique=True, nullable=False)
    phone_number = db.Column("phoneNumber", db.String(11), unique=True, index=True, nullable=False)
    photo_url = db.Column("photoUrl", db.String(), unique=True)
    verified_email = db.Column("verifiedEmail", db.Boolean(), default=False)
    verified_phone_number = db.Column("verifiedPhone", db.Boolean(), default=False)
    password_hash = db.Column("passwordHash", db.String(128), nullable=False)
    creation_date = db.Column(db.TIMESTAMP, server_default=db.func.current_timestamp(), nullable=False)
    last_login = db.Column(db.DateTime, index=False, unique=False, nullable=True)

  

    @property
    def password(self):
        raise AttributeError("Password not a readable attribute")

    @password.setter
    def password(self, password):
        self.password_hash = generate_password_hash(password)

    @property
    def is_email_verified(self):
        return self.verified_email

    @is_email_verified.setter
    def email_verified(self, value):
        self.verified_email = value

    @property
    def is_phone_number_verified(self):
        return self.verified_phone_number

    @is_phone_number_verified.setter
    def phone_number_verified(self, value):
        self.verified_phone_number = value

    @classmethod
    def check_user(cls, phone_number=None, email=None):
        user = cls.query.filter_by(email=email).first(
        ) or cls.query.filter_by(phone_number=phone_number).first()
        return user or False

    def verify_password(self, password):
        return check_password_hash(self.password_hash, password)

    @classmethod
    def create_user(cls, full_name, email, phone_number, password):
        if not cls.check_user(phone_number=phone_number, email=email):
            user = cls(full_name=full_name, email=email,
                       phone_number=phone_number)
            user.password = password
            db.session.add(user)
            db.session.commit()
            return user
        return None

    @classmethod
    def login(cls, identity, password):
        user = cls.check_user(phone_number=identity, email=identity)
        if user and user.verify_password(password):
            auth_token = user.generate_auth_token()
            return user, auth_token
        return None, None

    def generate_auth_token(self, expiration=3600):
        s = Serializer(current_app.config.get(
            'SECRET_KEY'), expires_in=expiration)
        return s.dumps({'id': str(self.id)}).decode('utf-8')

    @staticmethod
    def verify_auth_token(token):
        s = Serializer(current_app.config.get('SECRET_KEY'))
        try:
            data = s.loads(token)
        except SignatureExpired:
            return None
        except BadSignature:
            return None
        user = User.query.get(data['id'])
        return user

    def __repr__(self):
        return "<User {}>".format(self.full_name)


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


class UserSchema(ma.ModelSchema):
    # TODO: Fix minimum char length for fields
    class Meta:
        model = User
