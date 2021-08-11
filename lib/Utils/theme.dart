import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  canvasColor: Color(0xFFF0F1F6),
  brightness: Brightness.light,
  // primaryColor: AppColors.colorPrimary,
  // primaryColorDark: AppColors.colorPrimaryDark,
  primarySwatch: Colors.blue,
  // accentColor: AppColors.colorAccent,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),

  colorScheme: ColorScheme.light(
    primary: AppColors.primaryColor,
    secondary: AppColors.seconderyColor,
  ),
);

class AppColors {
  AppColors._();
  // static const Color colorAccent = Colors.green;
  // static const Color lightColorAccent = Color(0xFFFFFAF1);
  // static const Color colorPrimary = Color(0xFFF9B730);
  // static const Color colorPrimaryDark = Color(0xFFF0AC1D);

  static const Color primaryColor = Color(0xFF3B3054);
  static const Color seconderyColor = Color(0xFFF46262);
  static const Color accentColor = Color(0xFF2ACFCF);
  static const Color screenBackground = Color(0xFFF0F1F6);
  static const Color grey = Color(0xFF9E9AA7);
}
