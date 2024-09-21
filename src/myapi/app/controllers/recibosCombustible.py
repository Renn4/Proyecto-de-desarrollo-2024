from app.models.user_model import Recibos
from app.models.recibos_tipos import Recibos_tipos
from app.models.user_model import Usuarios
from app.controllers.cuentaCorrienteController import cuentaCorrienteController
from app.models.user_model import UsuariosTienenRecibos
from app.models.user_roles import Roles
from app.models.user_tiene_roles import UsuarioTieneRoles
from app.models.transacciones import Transacciones
from app import db
from datetime import datetime


class RecibosCombustibleController:

    def _init_(self):
        pass


    def crearRecibo(self,emailGestor,monto,observaciones,tipoPago, motivo):

            try:
                #me traigo el cliente
                cliente = db.session.query(Usuarios).filter_by(email="usuariocompracombustible@aero.com").first()
                #me traigo al gestor
                gestor = db.session.query(Usuarios).filter_by(email=emailGestor).first()

                rolGestor = db.session.query(Roles).filter_by(tipo='Gestor').first()
                gestorTieneRol = db.session.query(UsuarioTieneRoles).filter_by(usuarios_id=gestor.id_usuarios, roles_id=rolGestor.id_roles).first()
                
                rolCliente = db.session.query(Roles).filter_by(tipo='Cliente').first()
                clienteTieneRol = db.session.query(UsuarioTieneRoles).filter_by(usuarios_id=cliente.id_usuarios, roles_id=rolCliente.id_roles).first()

                if not (clienteTieneRol):

                    return 1
                
                if not (gestorTieneRol):

                    return 2
              
                fecha_actual = datetime.now()
                fecha= str(fecha_actual.year) + "-" + str(fecha_actual.month) + "-" + str(fecha_actual.day)

                if(monto>0):
                   
                   monto = monto*(-1) 


                #pago del cliente
                transaccionCliente = cuentaCorrienteController.actualizar_saldo(cuentaCorrienteController,cliente.id_usuarios,monto,fecha,motivo,tipoPago)
                    
                if transaccionCliente:
                        #traigo el tipoRecibo para usar el id
                        tipoRecibo = db.session.query(Recibos_tipos).filter_by(tipo="Recibo de Combustible").first()

                        num_recibo = 1    

                        reciboMayor = db.session.query(Recibos).order_by(Recibos.numero_recibos.desc()).first()

                        if reciboMayor:

                           num_recibo = reciboMayor.numero_recibos + 1    

                        #Se crea un recibo
                        recibo = Recibos(None,fecha_actual,observaciones,tipoRecibo.id_tipo_recibos,transaccionCliente.id_transacciones,num_recibo)
                
                        if recibo:

                             #guardamos el recibo
                            db.session.add(recibo)
                            db.session.commit()
                       
                            asociadoTieneRecibo = UsuariosTienenRecibos(None,recibo.id_recibos,cliente.id_usuarios,"Asociado")
                            gestorTieneRecibo = UsuariosTienenRecibos(None,recibo.id_recibos,gestor.id_usuarios,"Gestor")
                            
                            db.session.add(asociadoTieneRecibo)
                            db.session.add(gestorTieneRecibo)
                            db.session.commit()
                                
                            return 13     
                        else:
                            return 3  
           
            except Exception as ex:
                print(ex)

                if cliente:
                    if transaccionCliente:    
                        montoAsociado = transaccionCliente.monto 
                        idCuentaCorrienteAsociado = transaccionCliente.cuenta_corriente_id                     
                        db.session.delete(transaccionCliente)
                        resUno = cuentaCorrienteController.retrotraer_pago(cuentaCorrienteController,montoAsociado,idCuentaCorrienteAsociado)
                        print(f"se retrotrajo el pago del asociado: {resUno} ")
                    db.session.commit()   

                else:
                    return 4
                
                if not gestor:
                    return 5

                
                db.session.commit()        
               
                return 6           


"""

    def obtenerTodosLosRecibos(self):
        try:
                tipoRecibo = db.session.query(Recibos_tipos).filter_by(tipo="Recibo de Combustible").first()

                recibos = db.session.query(Recibos).filter_by(tipo_recibos_id = tipoRecibo.id_tipo_recibos).all()
            
                resultados_json = [{'id_recibos': recibo.id_recibos, 'nombre': recibo., 'apellido': usuario.apellido,'email': usuario.email} for recibo in recibos]
        
                if recibos:
                    return resultados_json
                else:
                    return False

        except Exception as ex:
            print(ex.args)
            return False
"""
