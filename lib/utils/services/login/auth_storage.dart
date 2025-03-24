import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static Future<void> saveCredentials(String usuario, String contrasena) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('usuario', usuario);
    await prefs.setString('contrasena', contrasena);
  }

  static Future<Map<String, String?>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'usuario': prefs.getString('usuario'),
      'contrasena': prefs.getString('contrasena'),
    };
  }

  // Eliminar credenciales (por ejemplo, al cerrar sesión)
  static Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('usuario');
    await prefs.remove('contrasena');
  }
}
