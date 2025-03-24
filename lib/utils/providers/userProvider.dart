import 'package:app_sara/utils/services/login/login_service.dart';
import 'package:app_sara/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  String? _userName;
  String? _userEmail;
  bool _canFoguear = false;

  String? get userName => _userName;
  String? get userEmail => _userEmail;
  bool get canFoguear => _canFoguear;

  final AuthService _authService = AuthService(); // Instancia del servicio

  Future<Map<String, dynamic>> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    _showLoadingDialog(context); // Mostrar diálogo de carga

    try {
      final result = await _authService.login(username, password);

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      if (result['status'] == 'success') {
        final roles = result['roles'] as List<String>;
        //_canFoguear = roles.contains("CUIDADOS_SUSTITUTOS");
        _canFoguear = roles.contains("ASISTENCIA_CENTROS");

        if (_canFoguear) {
          _userName = result['nombreuser'];
          _userEmail = "Bienvenid@";
          notifyListeners();

          return {
            'status': 'success',
            'nombreuser': _userName,
            'roles': roles,
            'canFoguear': _canFoguear,
          };
        } else {
          return {
            'status': 'error',
            'message': 'No tienes permisos para acceder.',
          };
        }
      } else {
        return result; // Retorna el error del servicio
      }
    } catch (e) {
      // Manejar errores específicos del servidor (500, 503)
      Navigator.pop(context); // Cerrar el diálogo de carga en caso de error
      if (e is http.Response) {
        if (e.statusCode == 500 || e.statusCode == 503) {
          return {
            'status': 'error',
            'message':
                'El servidor está en mantenimiento. Inténtalo de nuevo más tarde.',
          };
        }
      }
      // Re-lanzar otros errores para que sean manejados en el bloque catch de la llamada
      rethrow;
    }
  }

  void logout() {
    _userName = null;
    _userEmail = null;
    _canFoguear = false;
    notifyListeners();
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const LoadingDialog(
          message: "Autenticando, por favor espera...",
        );
      },
    );
  }
}
