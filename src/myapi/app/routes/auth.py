from flask import Blueprint, request, jsonify
from app.utils.Security import Security
from app.controllers.usuarios import UsuariosController
from app.controllers.roles import RolesController

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('', methods=['POST'])
def authCrearYDevolverToken():

    try:
        """
        data = request.get_json()
        email=data.get("email")
        nombre=data.get("nombre")
        apellido= data.get("apellido")
        telefono=data.get("telefono")
        dni=data.get("dni")
        direccion= data.get("direccion")
        """
        data = request.get_json()
        email=data.get("email")
        
        usuarioController= UsuariosController()
        respuestaCrearUsuario = usuarioController.crearUsuario(data)

        if respuestaCrearUsuario:
            
            rolesController = RolesController()
            respuestaRoles = rolesController.asignarAsociadoPorDefecto(email)

            if respuestaRoles:
                encoded_token = Security.generate_token(email)

                return jsonify({'token': encoded_token, 'success': True})
            
            else:
                return jsonify({'message': "No se pudo asignar el rol por defecto de Asociado", 'success': False})
            
        else:
            return jsonify({'message': "No se pudo crear el usuario", 'success': False})
        
    except Exception as ex:
        print(ex)
        return jsonify({'message': "ERROR", 'success': False})



@auth_bp.route('/<email>', methods=['GET'])
def chequearSiExisteUsuario(email):

    try:

        usuarioController = UsuariosController() 
        getUsuario = usuarioController.obtenerUsuarioPorEmail(email)

        if not getUsuario:

            return jsonify({'message': "No se encontro un usuario con este email", 'success': False})
        
        encoded_token = Security.generate_token(email)

        return jsonify({'token': encoded_token, 'success': True})
           
    except Exception as ex:
        print(ex)
        return jsonify({'message': "ERROR", 'success': False})





@auth_bp.route('', methods=['GET'])
def resolverToken():

    has_access = Security.verify_token(request.headers)
    
    if has_access:
        try:
            dataToken = Security.resolvertoken(request.headers)    

            if dataToken:

                return jsonify({'dataToken': dataToken, 'success': True})

            else:

                return jsonify({'message': 'No existe un token valido', 'success': False})   

        except Exception as ex:
            print(ex)
            return jsonify({'message': 'ocurrio un error', 'success': False})
    else:
        response = jsonify({'message': 'Unauthorized', 'success': False})
        return response, 401
    

