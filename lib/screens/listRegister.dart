import 'package:app_sara/utils/providers/providers.dart';
import 'package:app_sara/utils/services/login/login_dialog.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:app_sara/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRegisterScreen extends StatelessWidget {
  const ListRegisterScreen({super.key});

  static const routeName = '/listRegister';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Icon(
              Icons.list_alt,
              size: 100,
              color: TrackingColors.indigo,
            ), // Nuevo icono mejorado
            SizedBox(height: 20),
            Text(
              'No hay información disponible',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Intenta cargar los beneficiarios.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
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
                  //Navigator.of(context).pushNamed(RegisterScreen.routeName);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TrackingColors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Cargar Beneficiarios'),
            ),
          ],
        ),
      ),
    );
  }
}
