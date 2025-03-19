import 'package:app_sara/app/app.dart';
import 'package:app_sara/utils/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PasswordVisibilityProvider()),
      ],
      child: MyApp(),
    ),
  );
}
