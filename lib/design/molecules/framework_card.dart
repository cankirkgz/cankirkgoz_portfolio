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
                  color: widget.iconBackgroundColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: Image.asset(
                    widget.iconPath,
                    color: widget.iconBackgroundColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: AppSizes.fontWeightSemiBold,
                  fontSize: 16,
                ),
              ),
              if (widget.level != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: effectiveBadgeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    widget.level!,
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
        ),
      ),
    );
  }
}
