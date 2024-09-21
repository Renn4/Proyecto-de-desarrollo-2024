from app import db
from sqlalchemy import ForeignKey


class Transacciones(db.Model):
    __tablename__ = 'TRANSACCIONES'
    id_transacciones = db.Column(db.Integer, primary_key=True, autoincrement=True)
    monto = db.Column(db.Float, nullable=False)
    fecha = db.Column(db.Date, nullable=False)
    motivo = db.Column(db.Text,nullable=True)
    tipo_pago_id = db.Column(db.Integer, ForeignKey('TIPO_PAGO.id_tipo_pago'))
    cuenta_corriente_id = db.Column(db.Integer, ForeignKey('CUENTA_CORRIENTE.id_cuenta_corriente'))

    transaccionesRecibos = db.relationship('Recibos',back_populates='recibosTransacciones',cascade='all, delete-orphan')

    def __init__(self, id_transacciones , monto, fecha, motivo, tipo_pago_id,cuenta_corriente_id):
        self.id_transacciones = id_transacciones
        self.monto = monto
        self.fecha = fecha
        self.motivo = motivo
        self.tipo_pago_id = tipo_pago_id
        self.cuenta_corriente_id = cuenta_corriente_id