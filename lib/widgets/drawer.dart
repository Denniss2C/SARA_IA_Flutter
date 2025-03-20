import 'package:app_sara/screens/screens.dart';
import 'package:app_sara/utils/providers/providers.dart';
import 'package:app_sara/utils/services/login/login_dialog.dart';
import 'package:app_sara/utils/services/login/logout_dialog.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:app_sara/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      child: Column(
        children: [
          buildHeader(userProvider),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                buildDrawerItem(
                  icon: TrackingDrawables.getSVGPrincipal(),
                  title: 'Principal',
                  subtitle: 'Pantalla principal',
                  onTap: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                ),
                buildDrawerItem(
                  icon: TrackingDrawables.getSVGRegistroAsis(),
                  title: 'Registrar asistencia',
                  subtitle: 'Registro de marcación',
                  onTap: () {
                    Navigator.pushNamed(context, ListRegisterScreen.routeName);
                  },
                ),
                buildDrawerItem(
                  icon: TrackingDrawables.getSVGAsistenciaSinc(),
                  title: 'Asistencias por sincronizar',
                  subtitle: 'Asistencias pendientes de sincronizar',
                  onTap: () {
                    // Navegación a EncuestaRegistrada
                  },
                ),
                buildDrawerItem(
                  icon: TrackingDrawables.getSVGAcercaDe(),
                  title: 'Acerca de',
                  subtitle: 'Información aplicación',
                  onTap: () {
                    Navigator.pushNamed(context, AboutScreen.routeName);
                  },
                ),
                const Divider(),
                buildDrawerItem(
                  icon:
                      userProvider.userName != null
                          ? TrackingDrawables.getSVGLogout()
                          : TrackingDrawables.getSVGLogin(),
                  title:
                      userProvider.userName != null
                          ? 'Cerrar Sesión'
                          : 'Iniciar Sesión',
                  subtitle:
                      userProvider.userName != null
                          ? 'Cerrar sesión de la aplicación'
                          : 'Iniciar sesión en la aplicación',
                  onTap: () {
                    if (userProvider.userName != null) {
                      showLogoutDialog(context, userProvider);
                      // userProvider.logout();
                      //Navigator.pushNamed(context, HomeScreen.routeName);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Sesión cerrada')),
                      // );
                    } else {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                      showLoginDialog(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
