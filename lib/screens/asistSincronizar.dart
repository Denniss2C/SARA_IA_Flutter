import 'package:app_sara/utils/ui/ui.dart';
import 'package:app_sara/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AsistSincronizarScreen extends StatefulWidget {
  const AsistSincronizarScreen({super.key});

  static const routeName = '/asistSincronizar';

  @override
  State<AsistSincronizarScreen> createState() => _AsistSincronizarScreenState();
}

class _AsistSincronizarScreenState extends State<AsistSincronizarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  Theme.of(context).brightness == Brightness.light
                      ? [SaraColors.lightGrey, Colors.blueGrey.shade700]
                      : [SaraColors.negro, SaraColors.lightGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text(
              "ASISTENCIAS POR SINCRONIZAR",
              style: TextStyle(color: SaraColors.blanco),
            ),
            backgroundColor: Colors.transparent,
            //elevation: 0, // Sin sombra
            iconTheme: IconThemeData(color: SaraColors.blanco),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ],
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Icon(Icons.list_alt, size: 100, color: SaraColors.indigo),
            const SizedBox(height: 20),
            const Text(
              'No hay información disponible',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
