from app import db
from sqlalchemy import ForeignKey

class CuentaCorriente(db.Model):
    __tablename__ = 'CUENTA_CORRIENTE'
    id_cuenta_corriente = db.Column(db.Integer, primary_key=True, autoincrement=True)
    saldo_cuenta = db.Column(db.Float, nullable=False)
    usuarios_id = db.Column(db.Integer, ForeignKey('USUARIOS.id_usuarios'), nullable=False)



    def __init__(self, id_cuenta_corriente ,saldo_cuenta, usuarios_id):
        self.id_cuenta_corriente = id_cuenta_corriente
        self.saldo_cuenta = saldo_cuenta
        self.usuarios_id = usuarios_id

