import 'package:app_sara/utils/providers/providers.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:flutter/material.dart';

Widget buildHeader(UserProvider userProvider) {
  //Obtener las iniciales del nombre del usuario
  String getInitials(String? userName) {
    if (userName == null || userName.isEmpty) {
      return ''; // Devuelve una cadena vacía si no hay nombre
    }
    List<String> nameParts = userName.split(' ');
    String initials = '';
    for (var part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0].toUpperCase(); // Convierte a mayúscula
      }
    }
    return initials.length > 2 ? initials.substring(0, 2) : initials;
  }

  return Container(
    padding: const EdgeInsets.all(TrackingDimens.dimen_24),
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [TrackingColors.lightGrey, Colors.blueGrey.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      children: [
        SizedBox(height: 30),
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white,
          child:
              userProvider.userName != null
                  ? Text(
                    getInitials(userProvider.userName),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                  : Image.asset(TrackingDrawables.getUsuario()),
        ),
        const SizedBox(height: 10),
        Text(
          userProvider.userName ?? 'Sin iniciar sesión',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          userProvider.userEmail ?? '-----',
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    ),
  );
}
