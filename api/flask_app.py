import os
from flask_migrate import Migrate
# from user import db, create_app 
from user import db, create_app

app = create_app(os.getenv('FLASK_CONFIG') or 'default')
migrate = Migrate(app, db)
