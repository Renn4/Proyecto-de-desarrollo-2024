from app import db

class ItinerarioTipos(db.Model):
    __tablename__ = 'TIPO_ITINERARIOS'
    id_tipo_itinerarios = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tipo = db.Column(db.String(45))


    def __init__(self, id_tipo_itinerarios, tipo):
        self.id_tipo_itinerarios = id_tipo_itinerarios
        self.tipo = tipo