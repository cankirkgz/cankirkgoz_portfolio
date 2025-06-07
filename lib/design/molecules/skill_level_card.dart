import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class SkillLevelCard extends StatelessWidget {
  final String skillName;
  final String skillLevel;
  final int percentage;
  final Color color;
  final String iconPath;
  final List<Color>? gradientColors;

  const SkillLevelCard({
    super.key,
    required this.skillName,
    required this.skillLevel,
    required this.percentage,
    required this.color,
    required this.iconPath,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> usedGradient = gradientColors ??
        [
          AppColors.blueText,
          AppColors.purpleText,
        ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ÖNEMLİ: İçerik kadar yer kapla
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst kısım (icon, text, yüzde)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // İkon
                Container(
                  height: 48,
                  width: 48,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    iconPath,
                    color: color,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),

                // Yazılar
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // ÖNEMLİ
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skillName,
                        style: const TextStyle(
                          fontWeight: AppSizes.fontWeightSemiBold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        skillLevel,
                        style: TextStyle(
                          color: color,
                          fontSize: 14,
                          fontWeight: AppSizes.fontWeightMedium,
                        ),
                      ),
                    ],
                  ),
                ),

                // Yüzde
                Text(
                  '$percentage%',
                  style: TextStyle(
                    color: color,
                    fontWeight: AppSizes.fontWeightBold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: Container(
                height: 8,
                color: Colors.grey.shade200,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: usedGradient,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
