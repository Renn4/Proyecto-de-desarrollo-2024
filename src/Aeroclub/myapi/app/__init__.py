from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    CORS(app)
    app.config.from_pyfile('../config.py')
    
    db.init_app(app)

    # Importa rutas y realiza otras configuraciones necesarias
    from app.routes.usuarios import usuarios_bp
    app.register_blueprint(usuarios_bp,url_prefix='/usuarios')

    from app.routes.aeronaves import aeronaves_bp
    app.register_blueprint(aeronaves_bp, url_prefix='/aeronaves')

    from app.routes.roles import roles_bp
    app.register_blueprint(roles_bp, url_prefix='/roles')

    from app.routes.reciboVuelos import reciboVuelos_bp
    app.register_blueprint(reciboVuelos_bp, url_prefix='/recibo-vuelos')

    from app.routes.auth import auth_bp
    app.register_blueprint(auth_bp, url_prefix='/auth')

    from app.routes.reciboCombustible import reciboCombustible_bp
    app.register_blueprint(reciboCombustible_bp, url_prefix='/recibo-combustible')

    from app.routes.transacciones import transacciones_bp
    app.register_blueprint(transacciones_bp, url_prefix='/transacciones')

    from app.routes.cuentaCorriente import cuentaCorriente_bp
    app.register_blueprint(cuentaCorriente_bp, url_prefix='/cuentaCorriente')

    from app.routes.recibosPDF import reciboPDF_bp
    app.register_blueprint(reciboPDF_bp, url_prefix='/recibo-pdf')  
      
    return app