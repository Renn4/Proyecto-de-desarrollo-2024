from flask import Blueprint, request, jsonify
from app.utils.Security import Security
from app.controllers.recibos_pdf import ReciboPDF
#from app.controllers.recibos_pdf import generar_recibo


reciboPDF_bp = Blueprint('recibo-pdf', __name__)

@reciboPDF_bp.route('/<numRecibo>', methods=['GET'])
def obtenerRecibos(numRecibo):
  
    has_access = Security.verify_token(request.headers)
    
    if has_access:
        try:
                recibo_pdf = ReciboPDF()
                respuesta = recibo_pdf.crear_pdf(numRecibo)
                if respuesta:
                    return jsonify({'message': 'El pdf se creo', 'success': True})
                else:
                 
                    return jsonify({"message":'El pdf no se creo','success': False})
            
        except Exception as ex:
            print(ex)
            return jsonify({'message': 'ocurrio un error', 'success': False})
    else:
        response = jsonify({'message': 'Unauthorized'})
        return response, 401