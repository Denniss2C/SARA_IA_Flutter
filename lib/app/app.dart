import 'package:app_sara/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:app_sara/utils/routes.dart';
import 'package:app_sara/utils/ui/ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: routes,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      theme: TrackingThemes.light,
      darkTheme: TrackingThemes.dark,
      themeMode: ThemeMode.system,
      // Modificar el tema del texto
      // theme: ThemeData.light(useMaterial3: true).copyWith(
      //   textTheme: TextTheme(

      //   )
      // ),
    );
  }
}
