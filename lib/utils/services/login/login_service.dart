import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class AuthService {
  final String _baseUrl =
      'https://capacitacionalpha.inclusion.gob.ec/actben-ws/logmob-service?wsdl';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final soapBody = '''
  <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:impl="http://impl.service.siimies.web.login.mobile/">
      <soapenv:Body>
          <impl:autenticacion>
            <username>$username</username>
            <password>$password</password>
          </impl:autenticacion>
      </soapenv:Body>
  </soapenv:Envelope>
  ''';

    try {
      await Future.delayed(const Duration(seconds: 2));

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'text/xml; charset=utf-8'},
        body: soapBody,
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final document = xml.XmlDocument.parse(responseBody);

        String? getElementText(String tagName) {
          final element =
              document.findAllElements(tagName).isNotEmpty
                  ? document.findAllElements(tagName).first.text
                  : null;
          return element;
        }

        final cod = getElementText('cod');
        final iduser = getElementText('iduser');
        final mensaje = getElementText('mensaje');
        final nombreuser = getElementText('nombreuser');
        final token = getElementText('token');
        final rolesElements = document.findAllElements('rol');
        final roles = rolesElements.map((e) => e.text).toList();

        return {
          'status': 'success',
          'cod': cod,
          'iduser': iduser,
          'mensaje': mensaje,
          'nombreuser': nombreuser,
          'roles': roles,
          'token': token,
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
