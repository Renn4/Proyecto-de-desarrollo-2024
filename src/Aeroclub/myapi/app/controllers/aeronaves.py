from app.models.aeronave_models import Aeronaves
from app.controllers.estadosAeronaves import EstadoAeronavesController
from app import db
from flask import jsonify
from sqlalchemy.orm import joinedload

class AeronavesController:
    def __init__(self):
        pass

    def obtenerAeronavePorMatricula(self, matricula):
        try:
            aeronave = Aeronaves.query.filter_by(matricula=matricula).first()
            if aeronave:

                estadoFound = EstadoAeronavesController.obtenerEstadosAeronaveById(EstadoAeronavesController, aeronave.estados_aeronaves_id)    

                aeronave_data = {
                    'marca': aeronave.marca,
                    'modelo': aeronave.modelo,
                    'matricula': aeronave.matricula,
                    'potencia': aeronave.potencia,
                    'clase': aeronave.clase,
                    'fecha_adquisicion': aeronave.fecha_adquisicion,
                    'consumo_por_hora': aeronave.consumo_por_hora,
                    'path_documentacion': aeronave.path_documentacion,
                    'descripcion': aeronave.descripcion,
                    'path_imagen_aeronave': aeronave.path_imagen_aeronave,
                    'estados': estadoFound.get('estado')
                }
                return aeronave_data
            else:
                return False
            
        except Exception as ex:
            print(ex.args)
            return False   
        
       
    def obtenerAeronaves(self):

        idDeshabilitado = EstadoAeronavesController.obtenerIdEstadoDeshabilitada(EstadoAeronavesController)

        aeronaves = Aeronaves.query.filter(Aeronaves.estados_aeronaves_id != idDeshabilitado.get('id')).all()
        aeronave_list = []
        for aeronave in aeronaves:

            aeronave_data = {
                'id_aeronaves': aeronave.id_aeronaves,
                'marca': aeronave.marca,
                'modelo': aeronave.modelo,
                'matricula': aeronave.matricula,
                'potencia': aeronave.potencia,
                'clase': aeronave.clase,
                'fecha_adquisicion': aeronave.fecha_adquisicion,
                'consumo_por_hora': aeronave.consumo_por_hora,
                'path_documentacion': aeronave.path_documentacion,
                'descripcion': aeronave.descripcion,
                'path_imagen_aeronave': aeronave.path_imagen_aeronave,
                'estados_aeronaves_id': aeronave.estados_aeronaves_id,
            }
            aeronave_list.append(aeronave_data)
        return aeronave_list

    #al estar cargada no lo modificamos asi que no funciona como deberia en la db completa
    def crearAeronave(self, data):
        aeronave = Aeronaves(**data)
        db.session.add(aeronave)
        db.session.commit()
        return True

    def editarAeronave(self, matricula, data):
        aeronave = Aeronaves.query.filter_by(matricula=matricula).first()
        if aeronave:
            for key, value in data.items():
                setattr(aeronave, key, value)
            db.session.commit()
            return True
        return False

    def eliminarAeronave(self, matricula):
        aeronave = Aeronaves.query.filter_by(matricula=matricula).first()

        idDeshabilitado = EstadoAeronavesController.obtenerIdEstadoDeshabilitada(EstadoAeronavesController)

        if aeronave:
            aeronave.estados_aeronaves_id = idDeshabilitado.get('id')
            db.session.commit()
            return True
        return False
