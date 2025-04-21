import 'package:app_sara/utils/ui/color.dart';
import 'package:flutter/material.dart';

class SaraThemes {
  SaraThemes._();

  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: SaraColors.primario,
      scaffoldBackgroundColor: SaraColors.blanco,
      colorScheme: ColorScheme.light(
        primary: SaraColors.primario,
        surface: SaraColors.blanco,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: SaraColors.primaryDark,
      scaffoldBackgroundColor: SaraColors.negro,
      colorScheme: ColorScheme.dark(
        primary: SaraColors.primaryDark,
        surface: SaraColors.negro,
      ),
      useMaterial3: true,
    );
  }
}
