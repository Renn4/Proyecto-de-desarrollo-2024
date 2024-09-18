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

## GET /aeronaves/matricula
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
- **Cuerpo de la solicitud (JSON)**:
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

## PATCH /aeronaves/matricula
- **Descripción**: Actualiza una aeronave existente.
- **Método**: PATCH
- **Parámetros**: `matricula` (en la URL).
- **Cuerpo de la solicitud**: JSON con los nuevos datos de la aeronave.
- **Respuesta**:
  - **200 OK**: Aeronave actualizada con éxito. “Aeronave updated successfully” y el campo `success: True`.
  - **404 Not Found**: Si la aeronave no se encuentra. “Aeronave not found”.
  - **500 Internal Server Error**: Si ocurre un error. “An error occurred” y el campo `success: False`.

## DELETE /aeronaves/matricula
- **Descripción**: Elimina una aeronave basada en su matrícula.
- **Método**: DELETE
- **Parámetros**: `matricula` (en la URL).
- **Respuesta**:
  - **200 OK**: Aeronave eliminada con éxito. “Aeronave deleted successfully” y el campo `success: True`.
  - **404 Not Found**: Si la aeronave no se encuentra. “Aeronave not found”.
  - **500 Internal Server Error**: Si ocurre un error. “An error occurred” y el campo `success: False`.

---
# auth.py
# cuentaCorriente.py
# reciboCombustible.py
# recibosPDF.py
# recibosVuelos.py
# roles.py
# transacciones.py
# usuarios.py
