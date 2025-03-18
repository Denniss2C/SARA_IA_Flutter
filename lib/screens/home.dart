import 'package:flutter/material.dart';
import 'package:app_sara/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SARA", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 42, 55, 133),
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
      ),
      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset('assets/images/LOCOLOR.png', height: 100),
            // Text(
            //   "Ministerio de Inclusión Económica y Social",
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(20),
                children: [
                  _buildCard("Registro de Marcación", Icons.qr_code, context),
                  _buildCard("Por Sincronizar", Icons.sync, context),
                  _buildCard("Acerca de", Icons.info, context),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/flat_ecuador.png',
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.indigo),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
