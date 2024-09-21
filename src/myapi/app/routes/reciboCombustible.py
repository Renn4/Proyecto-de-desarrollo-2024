from flask import Blueprint, request, jsonify
from app.controllers.recibosCombustible import RecibosCombustibleController 
from app.controllers.transacciones import TransaccionesController
from app.utils.Security import Security


reciboCombustible_bp = Blueprint('recibo-combustible', __name__)

@reciboCombustible_bp.route('', methods=['POST'])
def crear_recibos_combustible():
  
    has_access = Security.verify_token(request.headers)
    
    if has_access:
        try:    
                data = request.get_json()
                emailGestor=data.get("emailGestor")
                observaciones=data.get("observaciones")
                monto=data.get("monto")
                tipoPago=data.get("tipoPago")
                motivo=data.get("motivo")
                recibosController = RecibosCombustibleController()
                respuesta = recibosController.crearRecibo(emailGestor,monto,observaciones,tipoPago, motivo)
                
                if respuesta == 1:
                    return jsonify({'mensaje': 'El cliente, no tiene rol de Cliente', 'success': False})
                if respuesta == 2:
                    return jsonify({'mensaje': 'El gestor que ingreso, no tiene rol de Gestor', 'success': False})
                if respuesta == 3:
                    return jsonify({'mensaje': 'No se pudo crear el recibo, intente nuevamente verificando los datos', 'success': False})
                if respuesta == 4:
                    return jsonify({'message': 'El cliente no es valido', 'success': False})
                if respuesta == 5:
                    return jsonify({'message': 'El gestor no es valido', 'success': False})
                if respuesta == 6:
                    return jsonify({'message': 'Ocurrio un error, verifiqué los datos y pruebe nuevamente', 'success': False})    
                if respuesta == 13:
                    return jsonify({'message': 'Recibo creado satisfactoriamente', 'success': True})        
            
        except Exception as ex:
            print(ex.args)
            return jsonify({'message': "error", 'success': False})
    else:
        response = jsonify({'message': 'Unauthorized'})
        return response, 401

"""
#devuelve todo los recibos que estan realcionados con los combustibles
@reciboCombustible_bp.route('/', methods=['GET'])
def obtenerTodosLosRecibosCombustibles():
  
    has_access = Security.verify_token(request.headers)
    
    if has_access:
        try:
                recibosController = RecibosCombustibleController()
                respuesta = recibosController.obtenerTodosLosRecibos()
                if respuesta :
                    return jsonify({"respuesta":respuesta,'success': True})
                else:
                    return jsonify({'message': 'No se encontraron recibos', 'success': False})
            
        except Exception as ex:
            print(ex)
            return jsonify({'message': 'ocurrio un error', 'success': False})
    else:
        response = jsonify({'message': 'Unauthorized'})
        return response, 401
"""
