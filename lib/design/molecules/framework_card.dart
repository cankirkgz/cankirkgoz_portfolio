// FrameworkCard.dart
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';

class FrameworkCard extends StatelessWidget {
  final String title;
  final String? level;
  final String iconPath;
  final Color iconBackgroundColor;
  final Color? badgeColor;

  const FrameworkCard({
    super.key,
    required this.title,
    this.level,
    required this.iconPath,
    required this.iconBackgroundColor,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBadgeColor = badgeColor ?? AppColors.blueText;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBackgroundColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              width: 28,
              height: 28,
              child: Image.asset(
                iconPath,
                color: iconBackgroundColor,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: AppSizes.fontWeightSemiBold,
              fontSize: 16,
            ),
          ),
          if (level != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: effectiveBadgeColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                level!,
                style: TextStyle(
                  color: effectiveBadgeColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
