import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_sara/screens/screens.dart';
import 'package:app_sara/utils/providers/providers.dart';
import 'package:app_sara/utils/services/login/login_dialog.dart';
import 'package:app_sara/utils/services/login/logout_dialog.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:app_sara/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    startListeningLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final permissionProvider = Provider.of<PermissionProvider>(
        context,
        listen: false,
      );
      if (!permissionProvider.dialogShown) {
        showPermissionDialog(context, permissionProvider);
      }
    });
  }

  Position? currentLocation;
  StreamSubscription? subscription;

  locationPermission({VoidCallback? inSuccess}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Servicio de ubicación desactivado');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied)
      permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.openAppSettings();
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return Future.error("Permisos de locacion no responde");
    }
    {
      inSuccess?.call();
    }
  }

  void startListeningLocation() {
    locationPermission(
      inSuccess: () async {
        subscription = Geolocator.getPositionStream(
          locationSettings:
              Platform.isAndroid
                  ? AndroidSettings(
                    accuracy: LocationAccuracy.high,
                    distanceFilter:
                        10, // Evita demasiadas actualizaciones innecesarias
                    forceLocationManager:
                        true, // Usa el LocationManager del sistema
                    intervalDuration: const Duration(seconds: 10),
                    foregroundNotificationConfig:
                        const ForegroundNotificationConfig(
                          notificationTitle: "Ubicación activa",
                          notificationText:
                              "Seguimiento de tu ubicación en segundo plano",
                          enableWakeLock:
                              false, // 🚨 Desactiva WAKE_LOCK para evitar el error
                        ),
                  )
                  : AppleSettings(
                    accuracy: LocationAccuracy.high,
                    activityType: ActivityType.fitness,
                    pauseLocationUpdatesAutomatically: true,
                    showBackgroundLocationIndicator: false,
                  ),
        ).listen((Position event) async {
          currentLocation = event;
          log(currentLocation.toString(), name: 'currentLocation');

          // Actualiza la ubicación en el Provider
          if (mounted) {
            Provider.of<LocationProvider>(
              context,
              listen: false,
            ).updateLocation(event.latitude, event.longitude);
          }
        });
      },
    );
  }

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
                      ? [SaraColors.lightGrey, Colors.blueGrey.shade700]
                      : [SaraColors.negro, SaraColors.lightGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text("SARA", style: TextStyle(color: SaraColors.blanco)),
            backgroundColor: Colors.transparent,
            //elevation: 0, // Sin sombra
            iconTheme: IconThemeData(color: SaraColors.blanco),
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
                    ? [Colors.blue.shade300, SaraColors.blanco]
                    : [Colors.blue.shade300, SaraColors.lightGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset(SaraDrawables.getLogoColor(), height: 100),
            SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 1000 ? 4 : 2;
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    padding: EdgeInsets.all(SaraDimens.dimen_32),
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
                          AsistSincronizarScreen.routeName,
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
                SaraDrawables.getFlatEcuador(),
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}
