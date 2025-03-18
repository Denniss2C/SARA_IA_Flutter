import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_sara/utils/providers/providers.dart';

Future<Map<String, String>?> showLoginDialog(BuildContext context) async {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  return await showDialog<Map<String, String>>(
    context: context,
    builder: (BuildContext context) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      //final passwordVisibilityProvider =
      //  Provider.of<PasswordVisibilityProvider>(context);
      return AlertDialog(
        title: const Text('Iniciar Sesión'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Usuario (Cédula)'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña (Cédula)',
                suffixIcon: IconButton(
                  icon: Icon(
                    //passwordVisibilityProvider.isPasswordVisible
                    Icons.visibility,
                    //: Icons.visibility_off,
                  ),
                  onPressed: () {
                    //passwordVisibilityProvider.togglePasswordVisibility();
                  },
                ),
              ),
              //obscureText: !passwordVisibilityProvider.isPasswordVisible,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo sin datos
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              String username = usernameController.text;
              String password = passwordController.text;
              if (username.isNotEmpty && password.isNotEmpty) {
                try {
                  await userProvider.login(
                    context,
                    username,
                    password,
                  ); // Llama al método login del UserProvider
                  Navigator.of(context).pop(); // Cierra el diálogo
                  if (userProvider.userName != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Bienvenido, ${userProvider.userName}'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Usuario o contraseña incorrectos'),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              } else if (username.isNotEmpty && password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, ingrese contraseña'),
                  ),
                );
              } else {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, ingrese usuario y contraseña'),
                  ),
                );
              }
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
