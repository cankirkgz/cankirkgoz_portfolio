import 'package:flutter/material.dart';

class AppColors {
  /// DARK MODE kontrolü
  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// PRIMARY COLORS
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color primaryblue = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFFBFDBFE);

  /// BACKGROUND
  static Color background(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF111827) : const Color(0xFFF9FAFB);

  static Color scaffoldBackground(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF1A1A1A) : const Color(0xFFFFFFFF);

  static Color card(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF1F2937) : const Color(0xFFFFFFFF);

  static Color grey(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);

  /// TEXT COLORS
  static Color textPrimary(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFFF3F4F6) : const Color(0xFF111827);

  static Color textSecondary(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  static Color textLight(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF);

  static const Color blueText = Color(0xFF667EEA);
  static const Color purpleText = Color(0xFF764BA2);
  static const Color pinkText = Color(0xFFF093FB);
  static const Color darkText = Color(0xFF1F2937);
  static const Color blackText = Color(0xFF4B5563);

  /// STATUS COLORS
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  /// CERTIFICATES
  static const Color certOrange = Color(0xFFEA580C);
  static const Color certGreen = Colors.green;
  static const Color certLightBlue = Color(0xFF61DAFB);
  static const Color certDarkBlue = Color(0xFF3776AB);
  static const Color certYellow = Color(0xFFFF9900);

  /// SKILLS
  static const Color skillOrange = Colors.orange;
  static const Color skillDeepOrange = Colors.deepOrange;
  static const Color skillOrangeAccent = Colors.orangeAccent;
  static const Color skillPurple = Colors.purple;

  /// BADGES
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF065F46);

  /// BORDERS & DIVIDERS
  static Color border(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static Color divider(BuildContext context) =>
      isDarkMode(context) ? const Color(0xFF4B5563) : const Color(0xFFCBD5E1);

  /// BUTTONS
  static const Color buttonPrimary = primary;
  static const Color buttonDisabled = Color(0xFF9CA3AF);

  /// ICONS
  static Color icon(BuildContext context) =>
      isDarkMode(context) ? Colors.white70 : const Color(0xFF6B7280);

  /// SHADOWS
  static Color shadow(BuildContext context) =>
      isDarkMode(context) ? Colors.black26 : const Color(0x1A000000);

  static Color shadowLight(BuildContext context) =>
      isDarkMode(context) ? Colors.black12 : const Color(0x0D000000);
}
