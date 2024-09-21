from sqlalchemy import ForeignKey
from app import db

class UsuarioTieneRoles(db.Model):
    __tablename__ = 'USUARIOS_tiene_ROLES'
    id_usuarios_tiene_roles = db.Column(db.Integer, primary_key=True, autoincrement=True)
    usuarios_id = db.Column(db.Integer, ForeignKey('USUARIOS.id_usuarios'))
    roles_id = db.Column(db.Integer, ForeignKey('ROLES.id_roles'))

    def __init__(self, id_usuarios_tiene_roles, usuarios_id, roles_id):
        self.id_usuarios_tiene_roles = id_usuarios_tiene_roles
        self.usuarios_id = usuarios_id
        self.roles_id = roles_id
