from flask import Blueprint, request, jsonify
from app.controllers.roles import RolesController
from app.utils.Security import Security
from app.controllers.usuarios import UsuariosController

roles_bp = Blueprint('roles', __name__)


# es necesario el email del usuario y en los datos tiene que ir los roles que debe tener
@roles_bp.route('/', methods=['POST'])
def agregar_rol():
  
    has_access = Security.verify_token(request.headers)
    
    if has_access:
        try:
                data = request.get_json()
                rolesController = RolesController()
                respuesta = rolesController.editarRol(data)
                if respuesta == 1:
                    return jsonify({'mensaje': 'Ese rol no esta permitido', 'success': False})
                if respuesta == 2:
                    return jsonify({'mensaje': 'Ya posee ese rol', 'success': True})
                if respuesta == 3:
                    return jsonify({'mensaje': 'El rol se le asigno correctamente', 'success': True})
                if respuesta == 4:
                    return jsonify({'message': 'El mail no es válido y no esta asociado a una cuenta', 'success': False})
        except Exception as ex:
            print(ex)
            return jsonify({'message': 'ocurrio un error', 'success': False})
    else:
        response = jsonify({'message': 'Unauthorized'})
        return response, 401
    

# Ruta para "borrar" un usuario por email
@roles_bp.route('/', methods=['DELETE'])
def delete_rol():
  
    has_access = Security.verify_token(request.headers)
    
    if has_access:
        try:
                data = request.get_json()
                rolesController = RolesController()
                respuesta = rolesController.eliminarRol(data)
                if respuesta == 1:
                    return jsonify({'mensaje': 'Ese rol no esta permitido', 'success': False})
                if respuesta == 2:
                    return jsonify({'mensaje': 'Se elimino el rol correctamente', 'success': True})
                if respuesta == 3:
                    return jsonify({'mensaje': 'El rol que quiere eliminar no lo posee, asi que no se realiza acciones', 'success': False})
                if respuesta == 4:
                    return jsonify({'message': 'El mail no es válido y no esta asociado a una cuenta', 'success': False})
        except Exception as ex:
            print(ex)
            return jsonify({'message': 'ocurrio un error', 'success': False})
    else:
        response = jsonify({'message': 'Unauthorized'})
        return response, 401


# Ruta para "borrar" un usuario por email
@roles_bp.route('/<email>', methods=['GET'])
def obtener_roles(email):
  
    has_access = Security.verify_token(request.headers)
    
    if has_access:
        try:
            arrayRoles = []
     
            usuarioController = UsuariosController() 
            getUsuario = usuarioController.obtenerUsuarioPorEmail(email)

            if getUsuario:

                rolesGetUsuario = getUsuario.get("roles")

                for rol in rolesGetUsuario:

                    arrayRoles.append(rol.get("tipo"))

            else:
                return jsonify({'message': "No se encontro un usuario con este email", 'success': False})

            return jsonify({'roles': arrayRoles, 'success': True})
             

        except Exception as ex:
            print(ex)
            return jsonify({'message': 'ocurrio un error', 'success': False})
    else:
        response = jsonify({'message': 'Unauthorized'})
        return response, 401