from flask import Blueprint, request, jsonify
from app.utils.Security import Security
from app.controllers.cuentaCorrienteController import cuentaCorrienteController

cuentaCorriente_bp = Blueprint('cuentaCorriente', __name__)

@cuentaCorriente_bp.route('/<int:usuario_id>', methods=['GET'])
def get_cuenta_corriente(usuario_id):
    has_access = Security.verify_token(request.headers)

    if has_access:
        try:
                cuenta_Controller = cuentaCorrienteController()
                saldo, success = cuenta_Controller.obtener_saldo(usuario_id)

                if success:
                    return jsonify({'saldo_cuenta': saldo, 'success': True})
                else:
                    return jsonify({'message': 'Cuenta corriente no encontrada para este usuario', 'success': False})
                
        
        except Exception as ex:
            print(ex)
            return jsonify({'message': 'ERROR', 'success': False})
    else:
        response = jsonify({'message': 'Unauthorized'})
        return response, 401
