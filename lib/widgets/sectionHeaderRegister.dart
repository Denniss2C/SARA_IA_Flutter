import 'package:flutter/material.dart';

Widget buildSectionHeader(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
