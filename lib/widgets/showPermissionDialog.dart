import 'package:app_sara/utils/providers/permissionProvider.dart';
import 'package:flutter/material.dart';

void showPermissionDialog(BuildContext context, PermissionProvider provider) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.assignment, color: Colors.blue),
            SizedBox(width: 8),
            Text("Conceder Permisos"),
          ],
        ),
        content: Text(
          "Es fundamental que conceda todos los permisos para poder acceder a todas las funcionalidades de la aplicación.",
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider
                  .setDialogShown(); // Guardar estado en SharedPreferences y Provider
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}
