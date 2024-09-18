# Documentación de endpoints del proyecto aeronaves SIGA

# aeronaves.py

## GET /aeronaves/
- **Descripción**: Devuelve una lista de todas las aeronaves.
- **Método**: GET
- **Autenticación**: Se requiere token de acceso en los encabezados.
- **Respuesta**:
  - **200 OK**: Lista de aeronaves en formato JSON. 
    - Si se encuentran aeronaves, devuelve un JSON con la lista y un campo `success: True`.
    - Si no hay aeronaves, devuelve un mensaje indicando que "No se encontraron las aeronaves" y el campo `success: False`.
  - **401 Unauthorized**: Si el token no es válido.
  - **500 Internal Server Error**: Si ocurre un error durante la ejecución.

## GET /aeronaves/{matricula}
- **Descripción**: Devuelve los detalles de una aeronave basada en su matrícula.
- **Método**: GET
- **Parámetros**: `matricula` (en la URL).
- **Respuesta**:
  - **200 OK**: Detalles de la aeronave en formato JSON.
    - Si encuentra la aeronave, devuelve un JSON con los detalles de la aeronave y el campo `success: True`.
    - Si no encuentra la aeronave con su matrícula, devuelve un mensaje indicando que "No se encontró la aeronave" y el campo `success: False`.
  - **404 Not Found**: Si la aeronave no se encuentra.
  - **500 Internal Server Error**: Si ocurre un error.

## POST /aeronaves/
- **Descripción**: Crea una nueva aeronave.
- **Método**: POST
- **Body** (JSON):
  - `marca (string)`: Marca de la aeronave.
  - `modelo (string)`: Modelo de la aeronave.
  - `matricula (string)`: Matrícula de la aeronave.
  - `potencia (number)`: Potencia del motor de la aeronave.
  - `clase (string)`: Clase de la aeronave.
  - `fecha_adquisicion (date)`: Fecha de adquisición.
  - `consumo_por_hora (number)`: Consumo por hora de la aeronave.
  - `path_documentacion (string)`: Ruta al archivo de documentación.
  - `descripcion (string)`: Descripción de la aeronave.
  - `path_imagen_aeronave (string)`: Ruta a la imagen de la aeronave.
  - `id_aeronaves (number)`: ID de la aeronave.
  - `estado_hab_des (boolean)`: Estado de habilitación.
- **Respuesta**:
  - **201 Created**: Aeronave creada con éxito. “Aeronave created successfully” y el campo `success: True`.
  - **400 Bad Request**: Datos de la aeronave no válidos. “Some data is invalid” y el campo `success: False`.
  - **500 Internal Server Error**: Si ocurre un error. “An error occurred” y el campo `success: False`.

## PATCH /aeronaves/{matricula}
- **Descripción**: Actualiza una aeronave existente.
- **Método**: PATCH
- **Parámetros**: `matricula` (en la URL).
- **Cuerpo de la solicitud**: JSON con los nuevos datos de la aeronave.
- **Respuesta**:
  - **200 OK**: Aeronave actualizada con éxito. “Aeronave updated successfully” y el campo `success: True`.
  - **404 Not Found**: Si la aeronave no se encuentra. “Aeronave not found”.
  - **500 Internal Server Error**: Si ocurre un error. “An error occurred” y el campo `success: False`.

## DELETE /aeronaves/{matricula}
- **Descripción**: Elimina una aeronave basada en su matrícula.
- **Método**: DELETE
- **Parámetros**: `matricula` (en la URL).
- **Respuesta**:
  - **200 OK**: Aeronave eliminada con éxito. “Aeronave deleted successfully” y el campo `success: True`.
  - **404 Not Found**: Si la aeronave no se encuentra. “Aeronave not found”.
  - **500 Internal Server Error**: Si ocurre un error. “An error occurred” y el campo `success: False`.

# auth.py

# cuentaCorriente.py

## GET /cuentaCorriente/{usuario_id}
- **Descripción**: Devuelve el saldo de la cuenta corriente de un usuario específico.
- **Método**: GET
- **Autenticación**: Se requiere token de acceso en los encabezados.
- **Parámetros**:
  - `usuario_id`: El ID del usuario del cual se desea consultar la cuenta corriente.
- **Respuesta**:
  - **200 OK**: Devuelve el saldo de la cuenta corriente en formato JSON.
    - Si se encuentra la cuenta corriente, devuelve un JSON con el saldo en el campo `saldo_cuenta` y `success: True`.
    - Si no se encuentra la cuenta corriente, devuelve un mensaje indicando que "Cuenta corriente no encontrada para este usuario" y `success: False`.
  - **401 Unauthorized**: Si el token no es válido.
  - **500 Internal Server Error**: Si ocurre un error durante la ejecución.

# reciboCombustible.py

## POST /recibo-combustible/
- **Descripción**: Crea un recibo de combustible.
- **Método**: POST
- **Autenticación**: Se requiere token de acceso en los encabezados.
- **Body** (JSON):
  - `emailGestor`: Email del gestor que crea el recibo.
  - `observaciones`: Observaciones adicionales sobre el recibo.
  - `monto`: Monto del recibo.
  - `tipoPago`: Tipo de pago (por ejemplo, efectivo, tarjeta, etc.).
  - `motivo`: Motivo del recibo.
- **Respuesta**:
  - **200 OK**:
    - **Caso de éxito**: Si el recibo se crea correctamente, devuelve el mensaje `Recibo creado satisfactoriamente` y `success: True`.
    - **Errores específicos**:
      - **1**: `El cliente no tiene rol de Cliente` y `success: False`.
      - **2**: `El gestor que ingresó no tiene rol de Gestor` y `success: False`.
      - **3**: `No se pudo crear el recibo, intente nuevamente verificando los datos` y `success: False`.
      - **4**: `El cliente no es válido` y `success: False`.
      - **5**: `El gestor no es válido` y `success: False`.
      - **6**: `Ocurrió un error, verifique los datos y pruebe nuevamente` y `success: False`.
  - **401 Unauthorized**: Si el token no es válido.
  - **500 Internal Server Error**: Si ocurre un error durante la ejecución.

# recibosPDF.py

## GET /recibo-pdf/{numRecibo}
- **Descripción**: Genera y devuelve un recibo en formato PDF según el número de recibo proporcionado.
- **Método**: GET
- **Autenticación**: Se requiere token de acceso en los encabezados.
- **Parámetros (URL Path)**:
  - `numRecibo`: Número del recibo para el cual se generará el PDF.
- **Respuesta**:
  - **200 OK**:
    - **Caso de éxito**: Si el PDF se genera correctamente, devuelve el mensaje `El pdf se creó` y `success: True`.
    - **Caso de error**: Si no se puede generar el PDF, devuelve el mensaje `El pdf no se creó` y `success: False`.
  - **401 Unauthorized**: Si el token no es válido o no está presente en los encabezados.
  - **500 Internal Server Error**: Si ocurre un error durante la ejecución del proceso.

# recibosVuelos.py

## GET /recibo-vuelos/{email}
- **Descripción**: Devuelve los recibos relacionados con vuelos para el asociado vinculado al correo proporcionado.
- **Método**: GET
- **Autenticación**: Se requiere token de acceso en los encabezados.
- **Parámetros (URL Path)**:
  - `email`: Correo electrónico del asociado para obtener sus recibos.
- **Respuesta**:
  - **200 OK**:
    - **Caso de éxito**: Devuelve los recibos asociados al correo y `success: True`.
    - **Error 1**: Si el correo no pertenece a un asociado, devuelve el mensaje `El mail no le pertenece a un asociado` y `success: False`.
    - **Error 2**: Si el asociado no tiene recibos, devuelve el mensaje `El asociado no tiene recibos aún` y `success: False`.
  - **401 Unauthorized**: Si el token no es válido.
  - **500 Internal Server Error**: Si ocurre un error durante la ejecución.

## GET /recibo-vuelos/
- **Descripción**: Devuelve todos los recibos relacionados con vuelos.
- **Método**: GET
- **Autenticación**: Se requiere token de acceso en los encabezados.
- **Respuesta**:
  - **200 OK**:
    - **Caso de éxito**: Devuelve todos los recibos disponibles y `success: True`.
    - **Error 1**: Si no existen recibos, devuelve el mensaje `No hay recibos de vuelos` y `success: False`.
  - **401 Unauthorized**: Si el token no es válido.
  - **500 Internal Server Error**: Si ocurre un error durante la ejecución.

## POST /recibo-vuelos/
- **Descripción**: Crea un recibo para vuelos.
- **Método**: POST
- **Autenticación**: Se requiere token de acceso en los encabezados.
- **Body** (JSON):
  - `emailAsociado`: Correo del asociado.
  - `emailInstructor`: Correo del instructor.
  - `emailGestor`: Correo del gestor.
  - `observaciones`: Observaciones del recibo.
  - `matricula`: Matrícula de la aeronave.
  - `fecha`: Fecha del vuelo.
  - `itinerarios`: Detalles de los itinerarios.
  
- **Respuesta**:
  - **200 OK**:
    - **Caso de éxito**: Si se crea el recibo y el PDF, devuelve `Recibo creado satisfactoriamente` y `success: True`.
    - **Error 1**: Si el asociado no tiene rol de asociado, devuelve `El asociado que ingresó, no tiene rol de Asociado` y `success: False`.
    - **Error 2**: Si el gestor no tiene rol de gestor, devuelve `El gestor que ingresó, no tiene rol de Gestor` y `success: False`.
    - **Error 3**: Si el instructor no tiene rol de instructor, devuelve `El instructor que ingresó, no tiene rol de instructor` y `success: False`.
    - **Errores adicionales**: Hay múltiples mensajes para otros posibles errores (instructor no válido, datos de itinerarios erróneos, etc.).
    - **PDF creado**: Si el PDF no se envía por algún motivo, devuelve `Se creó el recibo pero no se envió el mail por algún motivo` y `success: True`.
  - **401 Unauthorized**: Si el token no es válido.
  - **500 Internal Server Error**: Si ocurre un error durante la ejecución.

## GET /recibo-vuelos/numero-recibo/{numRecibo}
- **Descripción**: Devuelve un recibo específico relacionado con un vuelo, identificado por el número de recibo.
- **Método**: GET
- **Autenticación**: Se requiere token de acceso en los encabezados.
- **Parámetros (URL Path)**:
  - `numRecibo`: Número del recibo a buscar.
- **Respuesta**:
  - **200 OK**:
    - **Caso de éxito**: Si el recibo se encuentra, devuelve los datos y `success: True`.
    - **Error**: Si el recibo no se encuentra, devuelve el mensaje `El recibo no se encuentra` y `success: False`.
  - **401 Unauthorized**: Si el token no es válido.
  - **500 Internal Server Error**: Si ocurre un error durante la ejecución.


# roles.py
# transacciones.py
# usuarios.py
