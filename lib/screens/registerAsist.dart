import 'package:app_sara/utils/providers/providers.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:app_sara/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterAsistScreen extends StatefulWidget {
  const RegisterAsistScreen({super.key});

  static const routeName = '/registerAsist';

  @override
  State<RegisterAsistScreen> createState() => _RegisterAsistScreenState();
}

class _RegisterAsistScreenState extends State<RegisterAsistScreen> {
  late LocationProvider locationProvider;
  Map<String, dynamic>? beneficiario; // Variable para guardar la info

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        locationProvider = Provider.of<LocationProvider>(
          context,
          listen: false,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Recibir los argumentos pasados
    beneficiario ??=
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
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
              "BENEFICIARIOS DEL CENTRO",
              style: TextStyle(color: TrackingColors.blanco),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: TrackingColors.blanco),
            centerTitle: true,
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header section
            buildSectionHeader('REGISTRO DE ASISTENCIA MIES'),

            if (beneficiario != null) ...[
              buildSectionContent('CENTRO', '${beneficiario!["nombreCentro"]}'),
              buildSectionContent(
                'SERVICIO',
                '${beneficiario!["nombresServicios"]}',
              ),
              buildSectionContent(
                'MODALIDAD',
                '${beneficiario!["nombresModalidades"]}',
              ),

              // Mostrar la información del beneficiario
              buildInfoCard(
                title: 'Nombres y apellidos',
                value:
                    "${beneficiario!["apellidoBeneficiario"]} ${beneficiario!["nombreBeneficiario"]}",
              ),
              buildInfoCard(
                title: 'Cédula de Identidad',
                value: beneficiario!["cedulaBeneficiario"],
              ),
            ],

            // Escucha el Provider y actualiza la UI automáticamente
            Consumer<LocationProvider>(
              builder: (context, locationProvider, child) {
                return Text(
                  "Ubicación: ${locationProvider.latitude?.toStringAsFixed(4) ?? 'Cargando...'}, ${locationProvider.longitude?.toStringAsFixed(4) ?? 'Cargando...'}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                );
              },
            ),

            // Divider line
            const Divider(thickness: 1.5),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Provider.of<LocationProvider>(
            context,
            listen: false,
          ).fetchCurrentLocation();
        },
        //hacer mas grande el boton y sin bordes redondos
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: TrackingDimens.dimen_8),
          child: const Text('REGISTRAR ASISTENCIA'),
        ),
      ),
    );
  }
}
