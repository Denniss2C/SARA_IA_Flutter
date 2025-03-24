import 'dart:convert';

import 'package:app_sara/utils/services/login/auth_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class CentroUsuariosService {
  final String _baseUrl =
      'https://capacitacionalpha.inclusion.gob.ec/centros-usuarios-ws/centros-usuarios-service?wsdl';

  Future<Map<String, dynamic>> consultarUsuariosCentros(
    String cedulaResponsable,
  ) async {
    final credentials = await AuthStorage.getCredentials();

    final usuario = credentials['usuario'];
    final contrasena = credentials['contrasena'];
    if (usuario == null || contrasena == null) {
      return {'status': 'error', 'message': 'No hay credenciales almacenadas'};
    }
    print(
      "Usuario: $usuario, Contraseña: $contrasena",
    ); // ✅ Verificar credenciales

    //'Basic ${base64Encode(utf8.encode('$usuario:$contrasena'))}';
    //final authHeader = '$usuario:$contrasena';
    final credenciales = base64Encode(utf8.encode('$usuario:$contrasena'));

    final soapBody = '''
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                      xmlns:impl="http://impl.service.siimies.web.centrosUsuarios/">
        <soapenv:Body>
            <impl:consultarUsuariosCentrosByResponsable>
              <cedula_Responsable>$cedulaResponsable</cedula_Responsable>
            </impl:consultarUsuariosCentrosByResponsable>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';

    try {
      await Future.delayed(const Duration(seconds: 2));

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'text/xml; charset=utf-8',
          'Authorization': 'Basic $credenciales',
        },
        body: soapBody,
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final document = xml.XmlDocument.parse(responseBody);

        // String? getElementText(String tagName) {
        //   final element =
        //       document.findAllElements(tagName).isNotEmpty
        //           ? document.findAllElements(tagName).first.text
        //           : null;
        //   return element;
        // }
        String? getElementText(xml.XmlElement element, String tagName) {
          final foundElement =
              element.findElements(tagName).isNotEmpty
                  ? element.findElements(tagName).first.text
                  : null;
          return foundElement;
        }

        final cod = getElementText(document.rootElement, 'cod');
        final mensaje = getElementText(document.rootElement, 'mensaje');
        final entityList = document.findAllElements('entitylist');

        List<Map<String, String>> beneficiarios =
            entityList.map((element) {
              return {
                'apellidoBeneficiario':
                    getElementText(element, 'apellidoBeneficiario') ?? '',
                'apellidoResponsable':
                    getElementText(element, 'apellidoResponsable') ?? '',
                'cedulaBeneficiario':
                    getElementText(element, 'cedulaBeneficiario') ?? '',
                'cedulaResponsable':
                    getElementText(element, 'cedulaResponsable') ?? '',
                'codModalidades':
                    getElementText(element, 'codModalidades') ?? '',
                'codServicios': getElementText(element, 'codServicios') ?? '',
                'estadoAsistenciaRecFac':
                    getElementText(element, 'estadoAsistenciaRecFac') ?? '',
                'estadoRecFacial':
                    getElementText(element, 'estadoRecFacial') ?? '',
                'id': getElementText(element, 'id') ?? '',
                'idBeneficiario':
                    getElementText(element, 'idBeneficiario') ?? '',
                'idCentros': getElementText(element, 'idCentros') ?? '',
                'idResponsable': getElementText(element, 'idResponsable') ?? '',
                'nombreBeneficiario':
                    getElementText(element, 'nombreBeneficiario') ?? '',
                'nombreCentro': getElementText(element, 'nombreCentro') ?? '',
                'nombreResponsable':
                    getElementText(element, 'nombreResponsable') ?? '',
                'nombresModalidades':
                    getElementText(element, 'nombresModalidades') ?? '',
                'nombresServicios':
                    getElementText(element, 'nombresServicios') ?? '',
                'sexo': getElementText(element, 'sexo') ?? '',
                'tipoUsuario': getElementText(element, 'tipoUsuario') ?? '',
              };
            }).toList();

        return {
          'status': 'success',
          'cod': cod,
          'mensaje': mensaje,
          'beneficiarios': beneficiarios,
        };
      } else {
        return {
          'status': 'error',
          'message': 'Error en la solicitud: ${response.statusCode}',
          'response': response.body,
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Excepción: $e'};
    }
  }
}
