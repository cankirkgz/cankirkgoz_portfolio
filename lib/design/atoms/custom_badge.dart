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
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6)
          : padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            BorderRadius.circular(borderRadius ?? (isMobile ? 24 : 32)),
      ),
      child: Wrap(
        spacing: isMobile ? 6 : 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (leftIconPath != null) ...[
            SizedBox(
              width: isMobile ? 10 : 12,
              height: isMobile ? 10 : 12,
              child: Image.asset(
                leftIconPath!,
              ),
            ),
          ],
          if (showDot) ...[
            Container(
              width: isMobile ? 6 : 8,
              height: isMobile ? 6 : 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: isMobile ? AppSizes.fontXs : AppSizes.fontS,
              fontWeight: FontWeight.w500,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
