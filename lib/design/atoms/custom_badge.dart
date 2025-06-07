import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class CustomBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color dotColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final bool showDot;
  final double? borderRadius;
  final String? leftIconPath;

  const CustomBadge({
    super.key,
    required this.text,
    this.backgroundColor = const Color(0xFFD1FAE5), // Light green
    this.dotColor = const Color(0xFF10B981), // Green
    this.textColor = const Color(0xFF065F46), // Darker green
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.showDot = true,
    this.borderRadius,
    this.leftIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 32),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leftIconPath != null) ...[
            SizedBox(
              width: 12,
              height: 12,
              child: Image.asset(
                leftIconPath!,
              ),
            ),
            const SizedBox(width: 4),
          ],
          if (showDot) ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: AppSizes.fontS,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
