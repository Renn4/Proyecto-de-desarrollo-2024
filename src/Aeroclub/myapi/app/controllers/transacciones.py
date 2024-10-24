from app.models.transacciones import Transacciones
from app.models.tipo_pago import TipoPago
from app.models.cuenta_corriente import CuentaCorriente
from app.models.user_model import Usuarios
from app.models.tipo_pago import TipoPago
from app import db
from flask import jsonify

# Una Cuenta Corriente no se deberá deshabilitar, a su vez tampoco se podrá crear, se inicializará con el valor de una transacción...

class TransaccionesController:

    def _init_(self):
        pass

    def __chequearTipoPago(self,tipoPago):

        tipos=["Cheque","Efectivo", "Transferencia"] 

        print(f"__chequearTipoPago tipoPago entro: {tipoPago}")

        resultado = [x for x in tipos if x==tipoPago]

        if resultado:
            return True

        else:
            return False
        
    
    def crearTransaccion(self, monto, fecha, motivo,tipoPago,idCuentaCorriente):

            try:
                #chequeando el tipo de pago 
                if self.__chequearTipoPago(self.__chequearTipoPago,tipoPago):

                    #aca me traigo el tipoPago para obtener su id    
                    tipoPagoDictionary = db.session.query(TipoPago).filter_by(tipo=tipoPago).first()

                    transaccion = Transacciones(None,monto,fecha,motivo,tipoPagoDictionary.id_tipo_pago,idCuentaCorriente)
                    
                    db.session.add(transaccion)
                    db.session.commit()

                    return transaccion

                else:
                    return False  
              
            except Exception as ex:
                print(ex)
                return False

    #Esta es solo de prueba para ver si funciona lo de borrar en cascada
    def eliminarTransaccion(self, id):

            try:
                    #chequeando el tipo de pago 
              
                    transaccion = db.session.query(Transacciones).filter_by(id_transacciones=id).first()
                    
                    db.session.delete(transaccion)
                    db.session.commit()

                    return True 
              
            except Exception as ex:
                print(ex)
                return False
            
    def obtenerTransacciones(self):

        try:
            transacciones = Transacciones.query.all()
            transaccion_list = []    

            for transaccion in transacciones:

                idCuentaCorriente = transaccion.cuenta_corriente_id
                cuentaCorriente = db.session.query(CuentaCorriente).filter_by(id_cuenta_corriente=idCuentaCorriente).first()
                usuario = db.session.query(Usuarios).filter_by(id_usuarios=cuentaCorriente.usuarios_id).first()
                tipoPago = db.session.query(TipoPago).filter_by(id_tipo_pago=transaccion.tipo_pago_id).first()
                transaccion_data = {
                    'id_transacciones': transaccion.id_transacciones,
                    'nombre_completo_usuario': usuario.nombre + " " + usuario.apellido,
                    'monto': transaccion.monto,
                    'fecha': transaccion.fecha,
                    'motivo': transaccion.motivo,
                    'tipo_pago_id': tipoPago.tipo,
                    'cuenta_corriente_id': transaccion.cuenta_corriente_id,
                }
                transaccion_list.append(transaccion_data)
            return transaccion_list
        
        except Exception as ex:
                print(ex)
                return False
        
    
    # Obtener todas las transacciones de un usuario según su id
    def obtener_transaccion(self, cuenta_corriente_id):
        transaccion_uid = Transacciones.query.filter_by(cuenta_corriente_id=cuenta_corriente_id)
        transaccion_uid_list = []

        for transaccion in transaccion_uid:   
             transaccion_data = {
                'id_transacciones': transaccion.id_transacciones,
                'monto': transaccion.monto,
                'fecha': transaccion.fecha,
                'motivo': transaccion.motivo,
                'tipo_pago_id': transaccion.tipo_pago_id,
                'cuenta_corriente_id': transaccion.cuenta_corriente_id,
            }
             transaccion_uid_list.append(transaccion_data)
        return transaccion_uid_list