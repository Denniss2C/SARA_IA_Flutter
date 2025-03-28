import 'package:flutter/material.dart';

class PasswordVisibilityProvider with ChangeNotifier {
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners(); // Notifica a los listeners que el estado ha cambiado
  }
}
