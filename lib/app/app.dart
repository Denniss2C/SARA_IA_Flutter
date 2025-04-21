import 'package:app_sara/screens/splash.dart';
import 'package:app_sara/utils/routes.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: routes,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      theme: SaraThemes.light,
      darkTheme: SaraThemes.dark,
      themeMode: ThemeMode.system,
    );
  }
}
