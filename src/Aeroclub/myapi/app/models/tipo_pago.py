from app import db

class TipoPago(db.Model):
    __tablename__ = 'TIPO_PAGO'
    id_tipo_pago = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tipo = db.Column(db.String(45), nullable=False, unique=True)
    observaciones = db.Column(db.Text,nullable=True)

    def __init__(self, id_tipo_pago ,tipo, observaciones):
        self.id_tipo_pago = id_tipo_pago
        self.tipo = tipo
        self.observaciones = observaciones