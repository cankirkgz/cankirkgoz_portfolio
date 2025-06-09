import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';

class TechIconCard extends StatefulWidget {
  /// Kartta gösterilecek ikonun asset yolu
  final String iconPath;

  /// İkonun hemen altındaki metin
  final String label;

  /// İkonun boyutu (hem width hem height)
  final double iconSize;

  /// Kartın kenarlarının yuvarlaklık yarıçapı
  final double borderRadius;

  /// Kartın kenarlık (border) rengi ve kalınlığı (opsiyonel)
  final Color? borderColor;
  final double borderWidth;

  const TechIconCard({
    super.key,
    required this.iconPath,
    required this.label,
    this.iconSize = AppSizes.buttonHeightS,
    this.borderRadius = 12,
    this.borderColor,
    this.borderWidth = 1,
  });

  @override
  State<TechIconCard> createState() => _TechIconCardState();
}

class _TechIconCardState extends State<TechIconCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      transform: _isHovering
          ? Matrix4.translationValues(0, -8, 0)
          : Matrix4.identity(),
      height: 90,
      width: 120,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor!, width: widget.borderWidth)
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow(context).withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            widget.iconPath,
            width: widget.iconSize,
            height: widget.iconSize,
          ),
          const SizedBox(height: 4),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: AppSizes.fontS,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary(context),
            ),
          ),
        ],
      ),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: card,
    );
  }
}
