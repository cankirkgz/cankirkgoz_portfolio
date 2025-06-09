import 'package:flutter/material.dart';
import 'package:my_portfolio/main.dart' show themeNotifier;
import 'package:my_portfolio/core/constants/app_colors.dart';

/// Küçük kare bir kart içinde "güneş / ay" ikonu.
/// Tıklanınca uygulamanın temasını `light ⇆ dark` arasında değiştirir.
class ThemeToggleIcon extends StatelessWidget {
  const ThemeToggleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    const double height = 40; // Kartın yüksekliği
    const double width = 40; // Kartın genişliği

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier, // >>> global notifier
      builder: (_, mode, __) {
        final bool isDark = mode == ThemeMode.dark;

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () =>
              themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: AppColors.grey(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isDark ? Icons.wb_sunny_rounded : Icons.dark_mode_rounded,
              color: AppColors.icon(context),
              size: 28,
            ),
          ),
        );
      },
    );
  }
}
