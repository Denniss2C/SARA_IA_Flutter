import 'package:app_sara/utils/services/login/auth_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';

void showAtencionDialog(BuildContext context) async {
  final credentials = await AuthStorage.getCredentials();
  final beneficiaryProvider = Provider.of<BeneficiariosProvider>(
    context,
    listen: false,
  );
  //obtener las credenciales del usuario
  final usuario = credentials['usuario'];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Atención!"),
        content: const Text(
          "Recuerde que la carga de beneficiatios se debe realizar únicamente"
          " cuando haya ingresos o egresos de usuarios, actualización de datos o cambio de responsables."
          " NO es necesario que se carguen los beneficiatios de manera diaria.",
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo sin hacer nada
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              //Navigator.pop(context);
              await beneficiaryProvider.cargarBeneficiarios(
                context,
                usuario ?? '',
              );
              Navigator.pop(context);
              if (beneficiaryProvider.totalBeneficiarios != 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Beneficiarios cargados correctamente'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No se encontraron beneficiarios'),
                  ),
                );
              }
            },
            child: const Text("Aceptar"),
          ),
        ],
      );
    },
  );
}
