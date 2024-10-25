from app import db
from sqlalchemy import ForeignKey

class Tarifas(db.Model):
    __tablename__ = 'TARIFAS'
    id_tarifas = db.Column(db.Integer, primary_key=True, autoincrement=True)
    vigente_desde = db.Column(db.Date, nullable=False)
    importe_vuelo = db.Column(db.Float, nullable=False)
    importe_instruccion= db.Column(db.Float,nullable=False)
    aeronaves_id = db.Column(db.Integer, ForeignKey('AERONAVES'))

    def __init__(self, id_tarifas , vigente_desde, importe_vuelo, importe_instruccion,aeronaves_id):
        self.id_tarifas = id_tarifas
        self.vigente_desde = vigente_desde
        self.importe_vuelo = importe_vuelo
        self.importe_instruccion = importe_instruccion
        self.aeronaves_id = aeronaves_id
        