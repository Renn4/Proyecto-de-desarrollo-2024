from app.models.estados_aeronaves import EstadosAeronaves
from app import db
from flask import jsonify


class EstadoAeronavesController:
    def __init__(self):
        pass

    def obtenerEstadosAeronaveById(self, id):
        estadoFound = EstadosAeronaves.query.get(id)
        if estadoFound:
            estadoSend = {
                'estado': estadoFound.estado,         
            }
            return estadoSend
        return False
    
    def obtenerIdEstadoDeshabilitada(self):

        estadoAeroFound = db.session.query(EstadosAeronaves).filter_by(estado="Deshabilitada").first()

        if estadoAeroFound:
            estadoAeroFound = {
                'id': estadoAeroFound.id_estados_aeronaves,         
            }
            return estadoAeroFound
        return False
    