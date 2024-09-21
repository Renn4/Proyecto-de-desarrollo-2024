from app import db
from sqlalchemy import ForeignKey

class Aeronaves(db.Model):
    __tablename__ = 'AERONAVES'
    id_aeronaves = db.Column(db.Integer, primary_key=True, unique=True, autoincrement=True)
    marca = db.Column(db.String(45), nullable=False)
    modelo = db.Column(db.String(45), nullable=False)
    matricula = db.Column(db.String(45), nullable=False, unique=True)
    potencia = db.Column(db.String(45), nullable=False)
    clase = db.Column(db.String(45), nullable=False)
    fecha_adquisicion = db.Column(db.Date, nullable=False)
    consumo_por_hora = db.Column(db.Integer, nullable=False)
    path_documentacion = db.Column(db.Text)
    descripcion = db.Column(db.Text)
    path_imagen_aeronave = db.Column(db.Text)
    estados_aeronaves_id = db.Column(db.Integer,ForeignKey('ESTADOS_AERONAVES.id_estados_aeronaves'))
  
    
    def __init__(self, id_aeronaves, marca, modelo, matricula, potencia, clase, fecha_adquisicion,
                  consumo_por_hora, path_documentacion, descripcion, path_imagen_aeronave, estados_aeronaves_id):
        self.id_aeronaves = id_aeronaves
        self.marca = marca
        self.modelo = modelo
        self.matricula = matricula
        self.potencia = potencia
        self.clase = clase
        self.fecha_adquisicion = fecha_adquisicion
        self.consumo_por_hora = consumo_por_hora
        self.path_documentacion = path_documentacion
        self.descripcion = descripcion
        self.path_imagen_aeronave = path_imagen_aeronave
        self.estados_aeronaves_id = estados_aeronaves_id 
       