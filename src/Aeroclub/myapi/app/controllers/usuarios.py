from app.models.user_model import Usuarios
#from app.models.user_roles import Roles
#from app.models.user_tiene_roles import UsuarioTieneRoles
from app.controllers.cuentaCorrienteController import cuentaCorrienteController
from sqlalchemy.orm import joinedload
from app import db
from flask import jsonify
from datetime import datetime
from operator import or_
from app.models.user_roles import Roles
from app.models.user_tiene_roles import UsuarioTieneRoles


class UsuariosController:
    
    def __init__(self):
        pass 

    def obtenerUsuarioPorEmail(self,mail):

        # Cargar la relación 'roles' utilizando joinedload
        #userMalFormato = db.session.query(Usuarios).filter(Usuarios.email == mail).options(joinedload(Usuarios.roles)).first()

        #userMalFormato = db.session.execute(db.select(Usuarios).filter_by(email=mail)).scalar_one()
        #usuario = db.session.query(Usuarios).filter(Usuarios.email == mail)
   
         # Cargar la relación 'roles' utilizando joinedload
        userMalFormato = db.session.query(Usuarios).filter_by(email=mail).options(joinedload(Usuarios.roles)).first()

        if not userMalFormato:
       
            return  False   

        usuario = {'id_usuarios': userMalFormato.id_usuarios, 
                    'nombre': userMalFormato.nombre,
                    'apellido': userMalFormato.apellido,
                    'email': userMalFormato.email,
                    'telefono': userMalFormato.telefono,
                    'dni': userMalFormato.dni,
                    'fecha_alta': userMalFormato.fecha_alta,
                    'fecha_baja': userMalFormato.fecha_baja,
                    'direccion': userMalFormato.direccion,
                    'foto_perfil': userMalFormato.foto_perfil,
                    'estado_hab_des': userMalFormato.estado_hab_des,
                    'roles': [
                    {
                        'id_roles': role.id_roles,
                        'tipo': role.tipo,
                    }
                    for role in userMalFormato.roles
                ] 
                     
                    }
   
        return usuario

    def obtenerUsuarios(self):
        # Cargar la relación 'roles' utilizando joinedload
        users = db.session.query(Usuarios).options(joinedload(Usuarios.roles)).all()

        users = Usuarios.query.all()
        user_list = [{'id_usuarios': user.id_usuarios, 
                        'nombre': user.nombre,
                        'apellido': user.apellido,
                        'email': user.email,
                        'telefono': user.telefono,
                        'dni': user.dni,
                        'fecha_alta': user.fecha_alta,
                        'fecha_baja': user.fecha_baja,
                        'direccion': user.direccion,
                        'foto_perfil': user.foto_perfil,
                        'estado_hab_des': user.estado_hab_des,
                        'roles': [
                    {
                        'id_roles': role.id_roles,
                        'tipo': role.tipo,
                    }
                    for role in user.roles
                ]  # Incluye los datos de la relación 'roles' 
                    } for user in users if user.estado_hab_des != 0]
        return user_list
        
    def crearUsuario(self, data):
        
        try:

            id_usuarios = data.get('id_usuarios')
            nombre = data.get('nombre')
            apellido = data.get('apellido')
            email = data.get('email')
            telefono = data.get('telefono')
            dni = data.get('dni')
            fecha_alta = data.get('fecha_alta')
            fecha_baja = data.get('fecha_baja')
            direccion = data.get('direccion')
            foto_perfil = data.get('foto_perfil')
            estado_hab_des = data.get('estado_hab_des')
            
            fecha_alta = datetime.now()
            estado_hab_des = 1
            #hacer un control exacto de cada input para devolver el error exacto
            if not email:
                return False

            usuario = Usuarios( id_usuarios=id_usuarios, nombre=nombre, apellido=apellido, 
                                email=email, telefono=telefono,
                                dni=dni, fecha_alta=fecha_alta, 
                                fecha_baja=fecha_baja, direccion=direccion, 
                                foto_perfil=foto_perfil, estado_hab_des=estado_hab_des)
            db.session.add(usuario)
            db.session.commit()
  
           #se crea la cuenta del usuario
            cuentaCorrienteController.crear_cuenta(cuentaCorrienteController,usuario.id_usuarios)
            
            return True
        
        except Exception as ex:
            print(ex.args)
            return False



    def editarUsuario(self, email, data):
       
        #solo trae el dicc y no la clase de la bd
        user = self.obtenerUsuarioPorEmail(email)
        #te trae un usuario de la bd
        usuario = Usuarios.query.get(user["id_usuarios"])

        if not usuario:
        
            return  False
        
        if 'nombre' in data:
            usuario.nombre = data['nombre']
        if 'apellido' in data:
            usuario.apellido = data['apellido']
        if 'email' in data:
            usuario.email = data['email']
        if 'telefono' in data:
            usuario.telefono = data['telefono']
        if 'dni' in data:
            usuario.dni = data['dni']
        if 'fecha_alta' in data:
            usuario.fecha_alta = data['fecha_alta']
        if 'fecha_baja' in data:
            usuario.fecha_baja = data['fecha_baja']
        if 'direccion' in data:
            usuario.direccion = data['direccion']
        if 'foto_perfil' in data:
            usuario.foto_perfil = data['foto_perfil']
        if 'estado_hab_des' in data:
            usuario.estado_hab_des = data['estado_hab_des']

        #para que te lo guarde primero hay que buscar en la db una clase del modelo
        #y despues cuando modifique un atributo de esa clase cuenta como que lo modifique 
        #y ahi el commit me lo toma como un cambio y lo guarda
        db.session.commit()
        return True
 
        

    def eliminarUsuario(self, email):
        
            user = self.obtenerUsuarioPorEmail(email)
            #te trae un usuario de la bd
            usuario = Usuarios.query.get(user["id_usuarios"])
        
            if not Usuarios:
            
                return  False
            #para "borrarlo"
            usuario.estado_hab_des = 0

            db.session.commit()
            return True


    def obtenerUsuarioPorNombre(self,nombre):
    
            usuarioNombre=db.session.query(Usuarios).filter(or_(Usuarios.nombre.like(f'%{nombre}%'), Usuarios.apellido.like(f'%{nombre}%'))).all()
            
            if not usuarioNombre:
    
                return  False   
    
            resultados_json = [{'id_usuarios': usuario.id_usuarios, 'nombre': usuario.nombre, 'apellido': usuario.apellido,'email': usuario.email} for usuario in usuarioNombre]
            
            return resultados_json
    
     #Obtener todos los Intructores
    def obtenerInstructores(self):
        try:
            # Obtener id_usuarios de UsuariosTienenRol con id_roles == 2
            rolInstructor = db.session.query(Roles).filter_by(tipo='Instructor').first()
            instructores_id = db.session.query(UsuarioTieneRoles).filter_by(roles_id=rolInstructor.id_roles).all() 
            
            # Almacena los id_usuarios en una lista
            id_usuarios_rol_dos = [usuario.usuarios_id for usuario in instructores_id]
            
            # Obtener los datos de los usuarios del array id_usuarios_rol_dos
            instructores_list = db.session.query(Usuarios).filter(Usuarios.id_usuarios.in_(id_usuarios_rol_dos)).all()
            
            # Construir la lista con los datos de cada instrutor
            instructores_data = [
                {
                    'id_usuarios': instructor.id_usuarios,
                    'nombre': instructor.nombre,
                    'apellido': instructor.apellido,
                    'email': instructor.email,
                    'telefono': instructor.telefono,
                    'dni': instructor.dni,
                    'fecha_alta': instructor.fecha_alta,
                    'fecha_baja': instructor.fecha_baja,
                    'direccion': instructor.direccion,
                    'foto_perfil': instructor.foto_perfil,
                    'estado_hab_des': instructor.estado_hab_des,
                    'roles': [
                        {
                            'id_roles': rol.id_roles,
                            'tipo': rol.tipo,
                        }
                        for rol in instructor.roles if rol.id_roles == 2
                    ]
                }
                for instructor in instructores_list if instructor.estado_hab_des != 0
            ]
            
            return instructores_data
        except Exception as ex:
                print(ex.args)
                return False
        
    def obtenerAsociados(self):
        try:
            # Obtener id_usuarios de UsuariosTienenRol con id_roles == 2
            rolAsociado = db.session.query(Roles).filter_by(tipo='Asociado').first()
            asociado_id = db.session.query(UsuarioTieneRoles).filter_by(roles_id=rolAsociado.id_roles).all() 
            
            # Almacena los id_usuarios en una lista
            id_usuarios_rol_asociado = [usuario.usuarios_id for usuario in asociado_id]
            
            # Obtener los datos de los usuarios del array id_usuarios_rol_asociado
            asociados_list = db.session.query(Usuarios).filter(Usuarios.id_usuarios.in_(id_usuarios_rol_asociado)).all()
            
            # Construir la lista con los datos de cada instrutor
            asociados_data = [
                {
                    'id_usuarios': asociado.id_usuarios,
                    'nombre': asociado.nombre,
                    'apellido': asociado.apellido,
                    'email': asociado.email,
                    'telefono': asociado.telefono,
                    'dni': asociado.dni,
                    'fecha_alta': asociado.fecha_alta,
                    'fecha_baja': asociado.fecha_baja,
                    'direccion': asociado.direccion,
                    'foto_perfil': asociado.foto_perfil,
                    'estado_hab_des': asociado.estado_hab_des,
                    'roles': [
                        {
                            'id_roles': rol.id_roles,
                            'tipo': rol.tipo,
                        }
                        for rol in asociado.roles if rol.id_roles
                    ]
                }
                for asociado in asociados_list if asociado.estado_hab_des != 0
            ]
            
            return asociados_data
        except Exception as ex:
                print(ex.args)
                return False