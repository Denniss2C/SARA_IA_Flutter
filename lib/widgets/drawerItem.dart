import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildDrawerItem({
  required String icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: SvgPicture.asset(icon, width: 30, height: 30),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: onTap,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  );
}
