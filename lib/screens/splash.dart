import 'dart:async';

import 'package:app_sara/screens/screens.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash";

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // ⏳ Espera 4 segundos y navega a la HomeScreen
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Obtiene el tema actual
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? SaraDrawables.getLogoColor()
                  : SaraDrawables.getLogoBlanco(),
            ),
            const Padding(
              padding: EdgeInsets.only(top: SaraDimens.dimen_24),
              child: CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
      ),
    );
  }
}
