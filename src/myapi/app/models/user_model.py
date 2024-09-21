from app import db


class UsuariosTienenRecibos(db.Model):
    __tablename__ = 'USUARIOS_tienen_RECIBOS'
    id_usuarios_tienen_recibos = db.Column(db.Integer, primary_key=True, autoincrement=True)
    recibos_id = db.Column(db.Integer, db.ForeignKey('RECIBOS.id_recibos'))
    usuarios_id = db.Column(db.Integer, db.ForeignKey('USUARIOS.id_usuarios'))
    rol = db.Column(db.String(45), nullable=False,)

    usuarios = db.relationship('Usuarios', back_populates='relaciones')
    recibos = db.relationship('Recibos', back_populates='relaciones')

    #para borrar en casacada
    #tienenRecibos = db.relationship('Recibos',back_populates='recibosTienen') 

    def __init__(self, id_usuarios_tienen_recibos,recibos_id, usuarios_id, rol):
        self.id_usuarios_tienen_recibos = id_usuarios_tienen_recibos
        self.recibos_id = recibos_id
        self.usuarios_id = usuarios_id
        self.rol = rol


class Usuarios(db.Model):
    __tablename__ = 'USUARIOS'
    id_usuarios = db.Column(db.Integer, primary_key=True, autoincrement=True)
    nombre = db.Column(db.String(45), nullable=False)
    apellido = db.Column(db.String(45), nullable=False)
    email = db.Column(db.String(45), nullable=False, unique=True)
    telefono = db.Column(db.Integer, nullable=False)
    dni = db.Column(db.Integer, nullable=False, unique=True)
    fecha_alta = db.Column(db.Date, nullable=False)
    fecha_baja = db.Column(db.Date, nullable=False)
    direccion = db.Column(db.String(100))
    foto_perfil = db.Column(db.Text)
    estado_hab_des = db.Column(db.Integer, nullable=False)

    roles = db.relationship("Roles", secondary="USUARIOS_tiene_ROLES", back_populates="usuarios")
    #recibos = db.relationship("Recibos", secondary="USUARIOS_tienen_RECIBOS", back_populates="usuarios")
    relaciones = db.relationship('UsuariosTienenRecibos', back_populates='usuarios')

    def __init__(self, id_usuarios ,nombre, apellido, email, telefono, dni, fecha_alta, fecha_baja, direccion, foto_perfil, estado_hab_des):
        self.id_usuarios = id_usuarios
        self.nombre = nombre
        self.apellido = apellido
        self.email = email
        self.telefono = telefono
        self.dni = dni
        self.fecha_alta = fecha_alta
        self.fecha_baja = fecha_baja
        self.direccion = direccion
        self.foto_perfil = foto_perfil
        self.estado_hab_des = estado_hab_des

class Recibos(db.Model):
    __tablename__ = 'RECIBOS'
    id_recibos = db.Column(db.Integer, primary_key=True, autoincrement=True)
    fecha = db.Column(db.Date, nullable=False)
    observaciones = db.Column(db.Text)
    tipo_recibos_id = db.Column(db.Integer, db.ForeignKey('TIPO_RECIBOS.id_tipo_recibos'))
    transacciones_id = db.Column(db.Integer, db.ForeignKey('TRANSACCIONES.id_transacciones'))
    numero_recibos = db.Column(db.Integer, nullable=False)

    #usuarios = db.relationship("Usuarios", secondary="USUARIOS_tienen_RECIBOS", back_populates="recibos")
    relaciones = db.relationship('UsuariosTienenRecibos', back_populates='recibos',cascade='all, delete-orphan',single_parent=True)
    recibosTransacciones = db.relationship('Transacciones',back_populates='transaccionesRecibos')
    #para borrar en cascada
    recibosItinerarios = db.relationship('Itinerarios',back_populates='itinerariosRecibos',cascade='all, delete-orphan',single_parent=True)

    def __init__(self, id_recibos ,fecha, observaciones, tipo_recibos_id, transacciones_id,numero_recibos):
        self.id_recibos = id_recibos
        self.fecha = fecha
        self.observaciones = observaciones
        self.tipo_recibos_id = tipo_recibos_id
        self.transacciones_id = transacciones_id
        self.numero_recibos = numero_recibos