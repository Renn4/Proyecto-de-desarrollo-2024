from app import db

class Roles(db.Model):
    __tablename__ = 'ROLES'
    id_roles = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tipo = db.Column(db.String(45))

    usuarios = db.relationship("Usuarios", secondary="USUARIOS_tiene_ROLES", back_populates="roles")
    

    def __init__(self, id_roles, tipo):
        self.id_roles = id_roles
        self.tipo = tipo
       