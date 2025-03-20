import 'package:app_sara/utils/providers/providers.dart';
import 'package:flutter/material.dart';

import '../../../screens/screens.dart';

void showLogoutDialog(BuildContext context, UserProvider userProvider) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
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
            onPressed: () {
              userProvider.logout();
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
