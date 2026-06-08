import 'package:flutter/material.dart';

class AppTheme {
  // Colors - Light Mode
  static const Color _primaryColor = Color(0xFF00BCD4); // Light Blue for Tourism
  static const Color _secondaryColor = Color(0xFFFF5252); // Alert Red for Emergency
  static const Color _backgroundColor = Color(0xFFF5F7FA);
  static const Color _surfaceColor = Colors.white;
  static const Color _onPrimaryColor = Colors.white;
  static const Color _onBackgroundColor = Color(0xFF2C3E50);

  // Colors - Dark Mode
  static const Color _darkBackgroundColor = Color(0xFF121212);
  static const Color _darkSurfaceColor = Color(0xFF1E1E1E);
  static const Color _onDarkBackgroundColor = Color(0xFFE0E0E0);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: _primaryColor,
        secondary: _secondaryColor,
        surface: _surfaceColor,
        onPrimary: _onPrimaryColor,
        onSurface: _onBackgroundColor,
        error: _secondaryColor,
      ),
      scaffoldBackgroundColor: _backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _primaryColor,
        foregroundColor: _onPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: _onPrimaryColor,
        ),
      ),
      cardTheme: CardThemeData(
        color: _surfaceColor,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: _onPrimaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _secondaryColor,
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: _onBackgroundColor),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _onBackgroundColor),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: _onBackgroundColor),
        bodyLarge: TextStyle(fontSize: 16, color: _onBackgroundColor),
        bodyMedium: TextStyle(fontSize: 14, color: _onBackgroundColor),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: _primaryColor,
        secondary: _secondaryColor,
        surface: _darkSurfaceColor,
        onPrimary: _onPrimaryColor,
        onSurface: _onDarkBackgroundColor,
        error: _secondaryColor,
      ),
      scaffoldBackgroundColor: _darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkSurfaceColor,
        foregroundColor: _onDarkBackgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: _darkSurfaceColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: _onPrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _secondaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
