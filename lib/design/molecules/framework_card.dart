// FrameworkCard.dart
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';

class FrameworkCard extends StatefulWidget {
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
  State<FrameworkCard> createState() => _FrameworkCardState();
}

class _FrameworkCardState extends State<FrameworkCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color effectiveBadgeColor = widget.badgeColor ?? AppColors.blueText;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.p16),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: AppSizes.r12,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: AppSizes.shadowBlur,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.p12),
                decoration: BoxDecoration(
                  color: widget.iconBackgroundColor.withOpacity(0.15),
                  borderRadius: AppSizes.r16,
                ),
                child: SizedBox(
                  width: AppSizes.iconXL,
                  height: AppSizes.iconXL,
                  child: Image.asset(
                    widget.iconPath,
                    color: widget.iconBackgroundColor,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.p12),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: AppSizes.fontWeightSemiBold,
                  fontSize: AppSizes.fontM,
                ),
              ),
              if (widget.level != null) ...[
                const SizedBox(height: AppSizes.p8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.p12, vertical: AppSizes.p4),
                  decoration: BoxDecoration(
                    color: effectiveBadgeColor.withOpacity(0.15),
                    borderRadius: AppSizes.r999,
                  ),
                  child: Text(
                    widget.level!,
                    style: TextStyle(
                      color: effectiveBadgeColor,
                      fontSize: AppSizes.fontXs,
                      fontWeight: AppSizes.fontWeightMedium,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
