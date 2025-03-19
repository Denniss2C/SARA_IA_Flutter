import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:app_sara/utils/services/login/login_dialog.dart';
import 'package:app_sara/utils/providers/providers.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:app_sara/utils/routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    String _getInitials(String? userName) {
      if (userName == null || userName.isEmpty) return '';
      List<String> nameParts = userName.split(' ');
      return nameParts
          .map((part) => part[0].toUpperCase())
          .join()
          .substring(0, 2);
    }

    return Drawer(
      child: Column(
        children: [
          _buildHeader(userProvider),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: TrackingDrawables.getSVGPrincipal(),
                  title: 'Principal',
                  subtitle: 'Pantalla principal',
                  onTap: () {
                    // Navegación a HomeScreen
                  },
                ),
                _buildDrawerItem(
                  icon: TrackingDrawables.getSVGRegistroAsis(),
                  title: 'Registrar asistencia',
                  subtitle: 'Registro de marcación',
                  onTap: () {
                    // Navegación a EncuestaRegistrada
                  },
                ),
                _buildDrawerItem(
                  icon: TrackingDrawables.getSVGAsistenciaSinc(),
                  title: 'Asistencias por sincronizar',
                  subtitle: 'Asistencias pendientes de sincronizar',
                  onTap: () {
                    // Navegación a EncuestaRegistrada
                  },
                ),
                _buildDrawerItem(
                  icon: TrackingDrawables.getSVGAcercaDe(),
                  title: 'Acerca de',
                  subtitle: 'Información aplicación',
                  onTap: () {
                    // Navegación a Mies
                  },
                ),
                const Divider(),
                _buildDrawerItem(
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
                      userProvider.logout();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sesión cerrada')),
                      );
                    } else {
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

  Widget _buildHeader(UserProvider userProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child:
                userProvider.userName != null
                    ? Text(
                      //_getInitials(userProvider.userName),
                      "US",
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

  Widget _buildDrawerItem({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: SvgPicture.asset(icon, width: 30, height: 30),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        //color: Colors.grey,
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //tileColor: Colors.grey.shade200,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }
}
