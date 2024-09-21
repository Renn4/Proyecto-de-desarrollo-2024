from app import db

class EstadosAeronaves(db.Model):
    __tablename__ = 'ESTADOS_AERONAVES'
    id_estados_aeronaves = db.Column(db.Integer, primary_key=True, autoincrement=True)
    estado = db.Column(db.String(45))

    def __init__(self, id_estados_aeronaves, estado):
        self.id_estados_aeronaves = id_estados_aeronaves
        self.estado = estado