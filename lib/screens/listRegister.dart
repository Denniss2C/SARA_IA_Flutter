import 'package:app_sara/utils/providers/providers.dart';
import 'package:app_sara/utils/services/beneficiary/atencion_dialog.dart';
import 'package:app_sara/utils/services/login/login_dialog.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:app_sara/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ListRegisterScreen extends StatelessWidget {
  const ListRegisterScreen({super.key});

  static const routeName = '/listRegister';

  @override
  Widget build(BuildContext context) {
    final beneficiariosProvider = Provider.of<BeneficiariosProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  Theme.of(context).brightness == Brightness.light
                      ? [TrackingColors.lightGrey, Colors.blueGrey.shade700]
                      : [TrackingColors.negro, TrackingColors.lightGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text(
              "Beneficiarios del centro",
              style: TextStyle(color: TrackingColors.blanco),
            ),
            backgroundColor: Colors.transparent,
            //elevation: 0, // Sin sombra
            iconTheme: IconThemeData(color: TrackingColors.blanco),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ],
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body:
          beneficiariosProvider.primeraCarga ||
                  beneficiariosProvider.beneficiarios.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Icon(
                      Icons.list_alt,
                      size: 100,
                      color: TrackingColors.indigo,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'No hay información disponible',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Intenta cargar los beneficiarios.',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        final userProvider = Provider.of<UserProvider>(
                          context,
                          listen: false,
                        );
                        if (userProvider.userName == null) {
                          showLoginDialog(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Debe iniciar sesión para cargar los beneficiarios del centro',
                              ),
                            ),
                          );
                        } else {
                          // Muestra el diálogo y carga los beneficiarios
                          showAtencionDialog(context);
                          //beneficiariosProvider.cargarBeneficiarios();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TrackingColors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Cargar Beneficiarios'),
                    ),
                  ],
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: beneficiariosProvider.beneficiarios.length,
                  itemBuilder: (context, index) {
                    // Ordenamos la lista: primero los tipoUsuario "E", luego los demás
                    final sortedBeneficiarios =
                        beneficiariosProvider.beneficiarios
                            .where((b) => b["tipoUsuario"] == "E")
                            .toList()
                          ..addAll(
                            beneficiariosProvider.beneficiarios.where(
                              (b) => b["tipoUsuario"] != "E",
                            ),
                          );
                    // final sortedBeneficiarios = List.from(
                    //   beneficiariosProvider.beneficiarios,
                    // )..sort(
                    //   (a, b) => b["tipoUsuario"].compareTo(a["tipoUsuario"]),
                    // );
                    final beneficiario = sortedBeneficiarios[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          child: SvgPicture.asset(
                            beneficiario["tipoUsuario"] == "E"
                                ? TrackingDrawables.getSVGAsistenciaSinc()
                                : beneficiario["sexo"] == "MASCULINO"
                                ? TrackingDrawables.getSVGChico()
                                : TrackingDrawables.getSVGChica(),
                          ),
                        ),
                        title: Text(
                          beneficiario["tipoUsuario"] != "E"
                              ? "${beneficiario["apellidoBeneficiario"]!} ${beneficiario["nombreBeneficiario"]!}"
                              : beneficiario["nombreBeneficiario"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          "${beneficiario["tipoUsuario"] == "U" ? "BENEFICIARIO/A" : "EDUCADOR/A"}: ${beneficiario["cedulaBeneficiario"]}\nREGISTRO FACIAL: ${beneficiario["estadoAsistenciaRecFac"] != "A" || beneficiario["estadoRecFacial"] != "A" ? "INACTIVO" : "ACTIVO"}",
                          style: TextStyle(
                            color:
                                beneficiario["estadoAsistenciaRecFac"] == "I"
                                    ? Colors.red
                                    : Colors.green,
                          ),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                      ),
                    );
                  },
                ),
              ),
      bottomNavigationBar:
          !beneficiariosProvider.primeraCarga &&
                  beneficiariosProvider.beneficiarios.isNotEmpty
              ? Container(
                padding: const EdgeInsets.all(20),
                color: Colors.blue,
                child: Text(
                  "Total de Registros: ${beneficiariosProvider.totalBeneficiarios}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
              : null,
    );
  }
}
