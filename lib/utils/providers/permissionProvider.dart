import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionProvider extends ChangeNotifier {
  bool _dialogShown = false;

  bool get dialogShown => _dialogShown;

  PermissionProvider() {
    _loadDialogState(); // Cargar estado desde SharedPreferences
  }

  Future<void> _loadDialogState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _dialogShown = prefs.getBool('dialog_shown') ?? false;
    notifyListeners();
  }

  Future<void> setDialogShown() async {
    _dialogShown = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dialog_shown', true);
    notifyListeners();
  }
}
