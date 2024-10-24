from app.models.user_model import Usuarios
from app.models.user_roles import Roles
from app.controllers.usuarios import UsuariosController
from app.models.user_tiene_roles import UsuarioTieneRoles
from app import db



class RolesController:
    
    def __init__(self):
        pass 
    #esto hace que el metodo sea privado, solo accesible a la clase
    def __chequearArrayRoles(self,roles,rol):
       
        resultado = [x for x in roles if x.get('tipo')==rol]

        if resultado:
            return True

        else:
            return False
        
       #esto hace que el metodo sea privado, solo accesible a la clase
    def __chequearRolesPermitidos(self,rol):


        rolesPermitidos=["Asociado","Gestor","Instructor"]

        resultado = [x for x in rolesPermitidos if x==rol]

        if resultado:
            return True

        else:
            return False    


    def editarRol(self,data):
            
            #Obtenemos el userDictionary
            userDictionary = UsuariosController.obtenerUsuarioPorEmail(self,data.get('email'))

            try:
                if self.__chequearRolesPermitidos(data.get('rol')):
                    
                        if self.__chequearArrayRoles(userDictionary.get('roles'),data.get('rol')):

                            return 2
                        
                        else:

                            #nos traemos la data del rol que se paso por el endpoint
                            rol=data.get('rol')
                            rolDictionary = db.session.execute(db.select(Roles).filter_by(tipo=rol)).scalar_one()
                            #creo el usuarioTieneRoles

                            usuarioTieneRoles = UsuarioTieneRoles(0,userDictionary.get('id_usuarios'),rolDictionary.id_roles)

                            db.session.add(usuarioTieneRoles)
                            db.session.commit()              

                            return 3

                else:
                    return 1  
              
            except Exception as ex:
                print(ex)
                return 4



    def eliminarRol(self,data):
            
            #Obtenemos el userDictionary
            userDictionary = UsuariosController.obtenerUsuarioPorEmail(self,data.get('email'))

            try:
                if self.__chequearRolesPermitidos(data.get('rol')):
                    
                        if self.__chequearArrayRoles(userDictionary.get('roles'),data.get('rol')):

                            rolData=data.get('rol')

                            id_usuario = userDictionary.get('id_usuarios')

                            rolEncontrado = db.session.execute(db.select(Roles).filter_by(tipo=rolData)).scalar_one()
                            
                            rol_id = rolEncontrado.id_roles
                           
                            usuarioTieneRoles = db.session.execute(db.select(UsuarioTieneRoles).filter_by(usuarios_id=id_usuario, roles_id=rol_id)).scalar_one()    

                            db.session.delete(usuarioTieneRoles)
                            db.session.commit()              
                            
                            return 2
                        
                        else:        

                            return 3

                else:
                    return 1  
              
            except Exception as ex:
                print(ex)
                return 4

  
    def asignarAsociadoPorDefecto(self,email):
            
            try:     

                #Obtenemos el userDictionary
                userDictionary = UsuariosController.obtenerUsuarioPorEmail(self,email)        
                       
                rolDictionary = db.session.execute(db.select(Roles).filter_by(tipo="Asociado")).scalar_one()
                #creo el usuarioTieneRoles

                usuarioTieneRoles = UsuarioTieneRoles(0,userDictionary.get('id_usuarios'),rolDictionary.id_roles)

                db.session.add(usuarioTieneRoles)
                db.session.commit()              

                return True

             
              
            except Exception as ex:
                print(ex)
                return False