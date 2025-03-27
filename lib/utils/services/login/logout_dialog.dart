import 'package:app_sara/utils/providers/providers.dart';
import 'package:app_sara/utils/services/login/auth_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../screens/screens.dart';

void showLogoutDialog(BuildContext context, UserProvider userProvider) async {
  final beneficiariosProvider = Provider.of<BeneficiariosProvider>(
    context,
    listen: false,
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title: const Text("Confirmar Cierre"),
        content: const Text("¿Estás seguro de que quieres cerrar sesión?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo sin hacer nada
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              // Marcar el onPressed como async
              await AuthStorage.clearCredentials();
              userProvider.logout();
              beneficiariosProvider.resetOnLogout();

              Navigator.pushNamed(context, HomeScreen.routeName);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Sesión cerrada')));
            },
            child: const Text("Cerrar Sesión"),
          ),
        ],
      );
    },
  );
}
