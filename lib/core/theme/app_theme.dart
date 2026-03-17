import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Artisanal Moderne color palette
  static const Color rougeBoeuf = Color(0xFFA23B33);
  static const Color beigeFroid = Color(0xFFFDFDFD);
  static const Color graphite = Color(0xFF333333);
  static const Color moutarde = Color(0xFFE6C229);
  static const Color bordure = Color(0xFFDDDDDD);
  static const Color boisBrun = Color(0xFF5D4037);
  static const Color vertForet = Color(0xFF2E7D32);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: beigeFroid,
      colorScheme: ColorScheme.fromSeed(
        seedColor: rougeBoeuf,
        primary: rougeBoeuf,
        onPrimary: Colors.white,
        surface: Colors.white,
        onSurface: graphite,
      ),
      textTheme: GoogleFonts.montserratTextTheme().apply(
        bodyColor: graphite,
        displayColor: boisBrun,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: graphite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: graphite,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: bordure, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(88, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          backgroundColor: rougeBoeuf,
          foregroundColor: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: bordure),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: bordure),
        ),
      ),
    );
  }
}
