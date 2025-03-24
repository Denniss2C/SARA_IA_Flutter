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
            _buildSectionHeader('REGISTRO DE ASISTENCIA MIES'),

            _buildSectionContent('CENTRO', 'DEMOS LA MANO AMIGOS'),
            _buildSectionContent('SERVICIO', 'DESARROLLO INFANTIL INTEGRAL'),
            _buildSectionContent(
              'MODALIDAD',
              'CENTRO DE DESARROLLO INFANTIL-CDI-MIES (DIRECTOS - CONVENIOS)',
            ),

            // Beneficiary information
            _buildInfoCard(
              title: 'Nombres y apellidos',
              value: 'REYES MORA MARTHA JACQUELINE',
            ),
            _buildInfoCard(title: 'Cédula de Identidad', value: '1713824140'),

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
        child: const Text('ACTUALIZAR UBICACIÓN'),
      ),
    );
  }

  Widget _buildSectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSectionContent(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String value}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
