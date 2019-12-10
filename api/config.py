import os
from cred import *

basedir = os.path.abspath(os.path.dirname(__file__))


class Config:
    @staticmethod
    def init_app(app):
        pass


class DevelopmentConfig(Config):
    SECRET_KEY = "HGTO6rmUxIC_4maze8TIj54BPJ7IRb--Awsz_1oSELs"
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = "postgresql://{0}:{1}@localhost/{2}".format(
        username, password, database_name)


class TestingConfig(Config):
    # Add a secret key for testing
    TESTING = True
    SQLALCHEMY_DATABASE_URI = os.environ.get('TEST_DATABASE_URL') or \
        'sqlite://'


class ProductionConfig(Config):
    # Add a secret key for production
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or \
        'sqlite:///' + os.path.join(basedir, 'data.sqlite')


config = {
    'development': DevelopmentConfig,
    'testing': TestingConfig,
    'production': ProductionConfig,
    'default': DevelopmentConfig
}
