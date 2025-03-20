import 'package:app_sara/screens/screens.dart';
import 'package:app_sara/utils/providers/providers.dart';
import 'package:app_sara/utils/services/login/login_dialog.dart';
import 'package:app_sara/utils/services/login/logout_dialog.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:app_sara/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

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
            title: Text("SARA", style: TextStyle(color: TrackingColors.blanco)),
            backgroundColor: Colors.transparent,
            //elevation: 0, // Sin sombra
            iconTheme: IconThemeData(color: TrackingColors.blanco),
            centerTitle: true,
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                Theme.of(context).brightness == Brightness.light
                    ? [Colors.blue.shade300, TrackingColors.blanco]
                    : [Colors.blue.shade300, TrackingColors.lightGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset(TrackingDrawables.getLogoColor(), height: 100),
            SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 1000 ? 4 : 2;
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    padding: EdgeInsets.all(TrackingDimens.dimen_32),
                    children: [
                      buildCard(
                        "Registro de Marcación",
                        Icons.qr_code,
                        context,
                        () {
                          Navigator.pushNamed(
                            context,
                            ListRegisterScreen.routeName,
                          );
                        },
                      ),
                      buildCard("Por Sincronizar", Icons.sync, context, () {
                        Navigator.pushNamed(
                          context,
                          ListRegisterScreen.routeName,
                        );
                      }),
                      buildCard("Acerca de", Icons.info, context, () {
                        Navigator.pushNamed(context, AboutScreen.routeName);
                      }),
                      if (userProvider.userName != null) ...[
                        buildCard(
                          "Cerrar Sesión - ${userProvider.userName ?? 'Invitado'}",
                          Icons.logout,
                          context,
                          () {
                            // userProvider.logout();
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text('Sesión cerrada')),
                            // );
                            showLogoutDialog(context, userProvider);
                          },
                        ),
                      ] else ...[
                        buildCard("Iniciar Sesión", Icons.login, context, () {
                          showLoginDialog(context);
                        }),
                      ],
                    ],
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                TrackingDrawables.getFlatEcuador(),
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
