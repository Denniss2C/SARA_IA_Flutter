import 'package:app_sara/utils/services/beneficiary/user_centros_service.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class BeneficiariosProvider with ChangeNotifier {
  bool _primeraCarga = true;
  List<Map<String, String>> _beneficiarios = [];

  bool get primeraCarga => _primeraCarga;
  List<Map<String, String>> get beneficiarios => _beneficiarios;
  int get totalBeneficiarios => _beneficiarios.length;

  final CentroUsuariosService _centroUsuariosService = CentroUsuariosService();

  // Método para cargar beneficiarios desde la API
  Future<void> cargarBeneficiarios(
    BuildContext context,
    String cedulaResponsable,
  ) async {
    _showLoadingDialog(context); // Mostrar diálogo de carga
    _primeraCarga = true;
    notifyListeners();
    //print("📡 Iniciando solicitud a la API con cédula: $cedulaResponsable");

    try {
      final response = await _centroUsuariosService.consultarUsuariosCentros(
        cedulaResponsable,
      );

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      //print("🔄 Respuesta recibida: $response");

      if (response['status'] == 'success') {
        // Eliminar duplicados basados en cedulaBeneficiario
        final beneficiariosUnicos = _eliminarDuplicados(
          List<Map<String, String>>.from(response['beneficiarios']),
        );
        _beneficiarios = beneficiariosUnicos;
      } else {
        _beneficiarios = [];
      }
    } catch (e) {
      print("❌ Error al cargar beneficiarios: $e");
    }

    _primeraCarga = false;
    notifyListeners();
  }

  // Método para eliminar registros duplicados
  List<Map<String, String>> _eliminarDuplicados(
    List<Map<String, String>> lista,
  ) {
    final uniqueIds = <String>{};
    return lista.where((beneficiario) {
      final id =
          beneficiario['cedulaBeneficiario'] ?? beneficiario['idBeneficiario'];
      if (id == null || uniqueIds.contains(id)) {
        return false;
      }
      uniqueIds.add(id);
      return true;
    }).toList();
  }

  // Método para limpiar los beneficiarios
  void limpiarBeneficiarios() {
    _beneficiarios = [];
    _primeraCarga = true;
    notifyListeners();
  }

  void resetOnLogout() {
    _beneficiarios = [];
    _primeraCarga = true;
    notifyListeners();
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const LoadingDialog(message: "Cargando, por favor espera...");
      },
    );
  }
}
