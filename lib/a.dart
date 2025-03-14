import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, World!'),
        backgroundColor: Color.fromARGB(122, 33, 255, 13),
      ),
      body: Center(
        child: Container(
          color: Colors.red,
          child: Center(child: Text('Hello, World!')),
          height: 100,
        ),
      ),
    );
  }
}
