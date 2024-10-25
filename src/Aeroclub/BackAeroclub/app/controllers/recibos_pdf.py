import os
from fpdf import FPDF
from app import db 
from app.controllers.recibosVuelos import RecibosController
from app.models.user_model import Recibos
from dotenv import load_dotenv
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication
from app.models.user_model import UsuariosTienenRecibos
from app.models.user_model import Usuarios


class ReciboPDF(FPDF):
    
    def header(self):
        # Encabezado del PDF
        # Logo
        directorio_actual = os.path.dirname(os.path.abspath(__file__))
        # Construye la ruta al logo en la carpeta raíz
        ruta_logo = os.path.join(directorio_actual, 'logo.png')

        self.image(ruta_logo,10,8,33)
        self.set_font('Arial', 'B''U', 24)
        self.cell(0, 50, 'Recibo Aeroclub Lincoln', 0, 20, 'C')

    def datos_recibo(self, data, fecha,numRecibo):
        # Información del recibo
        self.set_font('Arial', '', 14)
        self.text(150,10,f"Fecha y Hora:")
        self.text(150,20,f"{fecha}")
        self.cell(190, 60, "", 1, 1)
        self.text(11,70,f"Asociado: {data['asociado']}")
        self.text(11,90,f"Instructor: {data['instructor']}")
        self.text(11,110,f"Gestor: {data['gestor']}")
        self.text(140,70,f"Número de recibo: ")
        self.set_font('Arial', 'B', 20)
        self.text(140,80,f" {numRecibo}")
        self.set_font('Arial', '', 14)
        self.text(140,90,f"Matrícula: {data['matricula']}")
        self.text(140,100,f"Precio Total:")
        self.set_font('Arial', 'B', 20)
        self.text(140,110,f"{data['precioTotal']}")
        self.set_font('Arial', '', 14)
        self.multi_cell(0, 20, f"Observaciones: {data['observaciones']}",1,1)
        self.cell(0, 10, '', 0, 1)  # Espacio entre itinerarios



    def itinerarios(self, itinerarios):
        # Detalles de los itinerarios
        count = 0
        for itinerario in itinerarios:
            count = count + 1
            self.set_font('Arial', 'B', 20)
            self.cell(0, 10, f'{count}° Itinerario', 0, 1)
            self.cell(0, 5, '', 0, 1)  # Espacio entre itinerarios
            self.set_font('Arial', '', 14)
            self.cell(0, 20, f"Hora de Salida: {itinerario['horaSalida']} - Código de aeropuerto de salida: {itinerario['codAeroSalida']}", 1, 1)
            self.cell(0, 20, f"Hora de Llegada: {itinerario['horaLlegada']} - Código de aeropuerto de llegada: {itinerario['codAeroLlegada']}", 1, 1)
            self.cell(0, 20, f"Tipo de Itinerario: {itinerario['tipoItinerario']} - Cantidad de aterrizajes: {itinerario['cantAterrizajes']}", 1, 1)
            self.cell(0, 10, '', 0, 1)  # Espacio entre itinerarios


    def generar_nombre_archivo(self, id_recibos):
    
        return os.path.join(os.path.expanduser('~'), 'Descargas', f"recibo_{id_recibos}.pdf")  #guarda el pdf en descargas, verificar autorizacion. EL NOMRE ES EL ID DEL RECIBO.

    def crear_pdf (self,numRecibo):
    # Crear el objeto PDF
        pdf = ReciboPDF()
        pdf.add_page()

        try:
            recibosController = RecibosController()
            recibos = recibosController.obtenerUnRecibo(numRecibo)
            print(f"recibos: {recibos}")
             # Datos del recibo
             
            recibo = db.session.query(Recibos).filter_by(numero_recibos=numRecibo).first()
            user_tiene_recibo = db.session.query(UsuariosTienenRecibos).filter_by(rol="Asociado",recibos_id=recibo.id_recibos).first()
            id_asociado = user_tiene_recibo.usuarios_id
            asociado = db.session.query(Usuarios).filter_by(id_usuarios =id_asociado).first()
            emailAsociado = asociado.email
            fecha_recibo = recibo.fecha

            numRecibo = recibo.numero_recibos
            pdf.datos_recibo(recibos[0], fecha_recibo,numRecibo)
            recibos.pop(0)
            pdf.itinerarios(recibos)

            namePdf = f'recibo-{numRecibo}.pdf'
            # Obtener el contenido del PDF como bytes
            pdf_bytes = pdf.output(dest="S").encode("latin1")
            #variables de entorno del email
            # Carga las variables de entorno desde el archivo .env
            load_dotenv()

            # Ahora puedes acceder a las variables de entorno como si estuvieran definidas en el sistema
            emailSmtp = os.getenv('EMAIL_SMTP')
            passwordSmtp = os.getenv('PASSWORD_SMTP')        

        # Envío por correo electrónico
            msg = MIMEMultipart()
            msg['Subject'] = 'Recibo'
            msg['From'] = emailSmtp  # Cambia esto al remitente real
            msg['To'] = emailAsociado # pasarle el emailAsociado correspondiente
            msg.attach(MIMEText(f'Adjunto encontrarás el recibo número {numRecibo}', "plain")) 
           #msg.set_content(f'Adjunto encontrarás el recibo número {numRecibo}') #Mensaje del cuerpo de email

            numRecibo = recibo.numero_recibos

            # Adjuntar el PDF al mensaje de correo electrónico
            # Convertir BytesIO a bytes
            pdf_attachment = MIMEApplication(pdf_bytes, _subtype="pdf")
            pdf_attachment.add_header('Content-Disposition', 'attachment', filename=namePdf)
            msg.attach(pdf_attachment)
            # Configura el servidor SMTP y envía el correo
            servidor_smtp = 'smtp.gmail.com'  # Cambia esto según tu proveedor de correo
            puerto_smtp = 587  # Cambia el puerto si es diferente (puede ser 465)
            usuario_smtp = emailSmtp  # Cambia esto al correo real
            password_smtp = passwordSmtp  # Cambia esto a tu contraseña real

            try:

                with smtplib.SMTP(servidor_smtp, puerto_smtp) as servidor:
                    servidor.starttls()       # inicia una conexión segura con el servidor SMTP mediante el protocolo TLS (Transport Layer Security)
                    servidor.login(usuario_smtp, password_smtp)
                    servidor.sendmail(usuario_smtp, emailAsociado, msg.as_string())

                print(f"El recibo ha sido enviado por correo electrónico {emailAsociado}")
            except Exception as e:
                    print(f"Error al enviar el correo electrónico: {e}") 

            return True
        
        except Exception as ex:
            print(ex)
            return  False
        