import 'package:app_sara/screens/screens.dart';
import 'package:app_sara/utils/ui/ui.dart';
import 'package:app_sara/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const routeName = '/about';

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
              "Acerca de",
              style: TextStyle(color: SaraColors.blanco),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: SaraColors.blanco),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              ),
            ],
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "SARA",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Text(
                "Sistema Automatizado de Registro de Asistencia",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Image.asset(SaraDrawables.getLogoSARA(), height: 200),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Versión 3.0",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SelectableText(
                        "Aplicación que permite registrar y controlar la asistencia de los usuarios de los centros de atención"
                        " a nivel nacional, de una forma segura, íntegra y en tiempo real, con información de geo-referenciación "
                        "y sistemas de reconocimiento único de usuarios a través de registro biométrico.",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Copyright 2025 MIES - ECUADOR",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Image.asset(
              SaraDrawables.getFlatEcuador(),
              fit: BoxFit.fitWidth,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
