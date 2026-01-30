import 'package:flutter/material.dart';

/// Centralized app colors. Change here to update theme; add dark variants if needed.
class AppColors {
  AppColors._();

  // Primary palette
  static const Color primary = Color.fromARGB(255, 33, 243, 103);
  static const Color primaryDark = Color.fromARGB(255, 12, 139, 65);
  static const Color primaryLight = Color.fromARGB(255, 114, 248, 114);

  // Secondary / accent
  static const Color secondary = Color(0xFF03A9F4);
  static const Color accent = Color(0xFF00BCD4);

  // Surfaces & background
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);

  // Semantic
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);

  // Text
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  /// Builds a [ColorScheme] from these colors for [ThemeData].
  static ColorScheme get colorScheme => ColorScheme.light(
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.white,
    surface: surface,
    onSurface: textPrimary,
    error: error,
    onError: Colors.white,
    onSurfaceVariant: textSecondary,
  );
}
