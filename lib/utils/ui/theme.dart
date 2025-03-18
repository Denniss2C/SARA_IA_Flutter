import 'package:flutter/material.dart';
import 'package:app_sara/utils/ui/color.dart';

class TrackingThemes {
  TrackingThemes._();

  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: TrackingColors.primario,
      scaffoldBackgroundColor: TrackingColors.blanco,
      colorScheme: ColorScheme.light(
        primary: TrackingColors.primario,
        surface: TrackingColors.blanco,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: TrackingColors.primaryDark,
      scaffoldBackgroundColor: TrackingColors.negro,
      colorScheme: ColorScheme.dark(
        primary: TrackingColors.primaryDark,
        surface: TrackingColors.negro,
      ),
    );
  }
}
