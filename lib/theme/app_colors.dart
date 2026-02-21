import 'package:flutter/material.dart';

class AppColors {
  // Brand & Background
  static const Color background = Color(0xFF0B0F19);
  static const Color surface = Color(0xFF161C2D);
  static const Color primary = Color(0xFF3366FF);
  static const Color primaryLight = Color(0xFF6690FF);

  // Risk Levels (Crisis Tracker)
  static const Color riskGreen = Color(0xFF00E676);
  static const Color riskYellow = Color(0xFFFFC400);
  static const Color riskRed = Color(0xFFFF1744);

  // Text Colors
  static const Color textPrimary = Color(0xFFF8F9FA);
  static const Color textSecondary = Color(0xFFADB5BD);

  // Borders & Accents
  static const Color border = Color(0xFF2B354D);
  static const Color overlay = Color(0x33FFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3366FF), Color(0xFF6690FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x11FFFFFF), Color(0x05FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
