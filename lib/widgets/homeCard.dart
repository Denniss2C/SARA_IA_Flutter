import 'package:app_sara/utils/ui/ui.dart';
import 'package:flutter/material.dart';

Widget buildCard(
  String title,
  IconData icon,
  BuildContext context,
  VoidCallback onTap,
) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    elevation: 4,
    child: InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 70,
            color:
                Theme.of(context).brightness == Brightness.light
                    ? TrackingColors.indigo
                    : TrackingColors.blanco,
          ),
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
