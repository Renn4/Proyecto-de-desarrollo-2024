from app import db
from sqlalchemy import ForeignKey

class ItinerarioTieneCodigosAeropuertos(db.Model):
    __tablename__ = 'ITINERARIOS_tienen_CODIGOS_AEROPUERTOS'
    id_itinerarios_tienen_codigos = db.Column(db.Integer, primary_key=True, autoincrement=True)
    itinerarios_id = db.Column(db.Integer, ForeignKey('ITINERARIOS.id_itinerarios'))
    codigos_aeropuertos_id = db.Column(db.Integer, ForeignKey('CODIGOS_AEROPUERTOS.id_codigos_aeropuertos'))

    itinerarios = db.relationship('Itinerarios', back_populates='relaciones')
    codigosaeropuerto = db.relationship('CodigoAeropuerto', back_populates='relaciones')

    def __init__(self, id_itinerarios_tienen_codigos, itinerarios_id, codigos_aeropuertos_id):
        self.id_itinerarios_tienen_codigos = id_itinerarios_tienen_codigos
        self.itinerarios_id = itinerarios_id
        self.codigos_aeropuertos_id = codigos_aeropuertos_id

class Itinerarios(db.Model):
    __tablename__ = 'ITINERARIOS'
    id_itinerarios = db.Column(db.Integer, primary_key=True, autoincrement=True)
    hora_salida = db.Column(db.DateTime, nullable=False)
    hora_llegada = db.Column(db.DateTime, nullable=False)
    cantidad_aterrizajes = db.Column(db.Integer, nullable=False)
    observaciones = db.Column(db.String(255))
    tipo_itinerarios_id = db.Column(db.Integer, ForeignKey('TIPO_ITINERARIOS.id_tipo_itinerarios'))
    aeronaves_id = db.Column(db.Integer, ForeignKey('AERONAVES.id_aeronaves'))
    RECIBOS_id_recibos= db.Column(db.Integer, ForeignKey('RECIBOS.id_recibos'))

    relaciones = db.relationship('ItinerarioTieneCodigosAeropuertos', back_populates='itinerarios',cascade='all, delete-orphan',single_parent=True)

    #para borrar en cascada
    itinerariosRecibos = db.relationship('Recibos',back_populates='recibosItinerarios')

    def __init__(self, id_itinerarios, hora_salida, hora_llegada, cantidad_aterrizajes, observaciones,tipo_itinerarios_id, aeronaves_id, RECIBOS_id_recibos ):
        self.id_itinerarios = id_itinerarios
        self.hora_salida = hora_salida
        self.hora_llegada = hora_llegada
        self.cantidad_aterrizajes = cantidad_aterrizajes
        self.observaciones = observaciones
        self.tipo_itinerarios_id = tipo_itinerarios_id
        self.aeronaves_id = aeronaves_id
        self.RECIBOS_id_recibos = RECIBOS_id_recibos
        
class CodigoAeropuerto(db.Model):
    __tablename__ = 'CODIGOS_AEROPUERTOS'
    id_codigos_aeropuertos = db.Column(db.Integer, primary_key=True, autoincrement=True)
    codigo_aeropuerto = db.Column(db.String(45))

    relaciones = db.relationship('ItinerarioTieneCodigosAeropuertos', back_populates='codigosaeropuerto')

    def __init__(self, id_codigos_aeropuertos, codigo_aeropuerto):
        self.id_codigos_aeropuertos = id_codigos_aeropuertos
        self.codigo_aeropuerto = codigo_aeropuerto