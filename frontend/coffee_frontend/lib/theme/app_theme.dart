import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF3E2723); // Deep Brown
  static const Color secondaryColor = Color(0xFF121212); // Black
  static const Color accentColor = Color(0xFF8D6E63); // Muted Brown
  static const Color backgroundColor = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color textColor = Color(0xFFEFEBE9);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: accentColor,
      surface: surfaceColor,
      background: backgroundColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: secondaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey),
    ),
    cardTheme: CardTheme(
      color: surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
