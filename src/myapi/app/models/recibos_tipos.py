from app import db

class Recibos_tipos(db.Model):
    __tablename__ = 'TIPO_RECIBOS'
    id_tipo_recibos = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tipo = db.Column(db.String(45),  nullable=False)

  
    def __init__(self, id_tipo_recibos, tipo):
        self.id_tipo_recibos = id_tipo_recibos
        self.tipo = tipo