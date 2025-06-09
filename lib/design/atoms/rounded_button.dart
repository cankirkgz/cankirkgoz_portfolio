import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

enum ButtonType {
  gradient,
  outline,
  card,
}

class RoundedButton extends StatefulWidget {
  final String firstText;
  final String? secondText;
  final String? icon;
  final String? rightIcon;
  final VoidCallback onPressed;
  final ButtonType type;
  final Color? iconColor;
  final Color? textColor;
  final List<Color>? gradientColors;
  final Color? backgroundColor;
  final bool hasShadow;
  final double? borderRadius;
  final double? width;
  final double? height;
  final Color? borderColor;
  final double? borderWidth;

  const RoundedButton({
    super.key,
    required this.firstText,
    this.secondText,
    this.icon,
    this.rightIcon,
    required this.onPressed,
    required this.type,
    this.iconColor,
    this.textColor,
    this.gradientColors,
    this.backgroundColor,
    this.hasShadow = false,
    this.borderRadius,
    this.width,
    this.height,
    this.borderColor,
    this.borderWidth,
  });

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Widget buildContent() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Image.asset(
                  widget.icon!,
                  height: widget.type == ButtonType.card
                      ? AppSizes.iconL
                      : AppSizes.iconS,
                  width: widget.type == ButtonType.card
                      ? AppSizes.iconL
                      : AppSizes.iconS,
                  color: widget.type == ButtonType.gradient
                      ? AppColors.scaffoldBackground(context)
                      : widget.iconColor ??
                          (widget.type == ButtonType.card
                              ? null
                              : AppColors.blackText),
                ),
                SizedBox(
                  width: widget.type == ButtonType.card
                      ? AppSizes.p10
                      : AppSizes.p8,
                ),
              ],
              Flexible(
                child: Text(
                  widget.firstText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: widget.type == ButtonType.gradient
                        ? AppColors.scaffoldBackground(context)
                        : widget.textColor ??
                            (widget.type == ButtonType.card
                                ? AppColors.textPrimary(context)
                                : AppColors.blackText),
                    fontSize: AppSizes.fontM,
                    fontWeight: AppSizes.fontWeightSemiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (widget.rightIcon != null) ...[
                SizedBox(
                  width: widget.type == ButtonType.card
                      ? AppSizes.p12
                      : AppSizes.p8,
                ),
                Image.asset(
                  widget.rightIcon!,
                  height: widget.type == ButtonType.card
                      ? AppSizes.iconL
                      : AppSizes.iconS,
                  width: widget.type == ButtonType.card
                      ? AppSizes.iconL
                      : AppSizes.iconS,
                  color: widget.type == ButtonType.gradient
                      ? AppColors.scaffoldBackground(context)
                      : widget.iconColor ??
                          (widget.type == ButtonType.card
                              ? null
                              : AppColors.blackText),
                ),
              ],
            ],
          ),
          if (widget.secondText != null) ...[
            const SizedBox(height: AppSizes.p2),
            Flexible(
              child: Text(
                widget.secondText!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: widget.type == ButtonType.gradient
                      ? AppColors.scaffoldBackground(context)
                      : (widget.textColor ??
                          (widget.type == ButtonType.card
                              ? AppColors.textSecondary(context)
                              : AppColors.blackText.withOpacity(0.7))),
                  fontSize: AppSizes.fontM,
                  fontWeight: AppSizes.fontWeightSemiBold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      );
    }

    BoxDecoration getDecoration() {
      final colors =
          widget.gradientColors ?? [AppColors.blueText, AppColors.purpleText];
      final gradientColors = _isHovered ? [colors[1], colors[0]] : colors;

      switch (widget.type) {
        case ButtonType.gradient:
          return BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
            ),
            borderRadius: widget.borderRadius != null
                ? BorderRadius.circular(widget.borderRadius!)
                : AppSizes.r12,
            border: widget.borderColor != null
                ? Border.all(
                    color: widget.borderColor!,
                    width: widget.borderWidth ?? AppSizes.p1,
                  )
                : null,
            boxShadow: widget.hasShadow
                ? [
                    BoxShadow(
                      color: AppColors.shadow(context).withOpacity(0.1),
                      blurRadius: AppSizes.shadowBlur,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          );
        case ButtonType.outline:
          return BoxDecoration(
            color: AppColors.scaffoldBackground(context),
            border: Border.all(
              color: widget.borderColor ?? AppColors.border(context),
              width: widget.borderWidth ?? AppSizes.p1,
            ),
            borderRadius: widget.borderRadius != null
                ? BorderRadius.circular(widget.borderRadius!)
                : AppSizes.r12,
            boxShadow: widget.hasShadow
                ? [
                    BoxShadow(
                      color: AppColors.shadow(context).withOpacity(0.1),
                      blurRadius: AppSizes.shadowBlur,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          );
        case ButtonType.card:
          return BoxDecoration(
            color:
                widget.backgroundColor ?? AppColors.scaffoldBackground(context),
            borderRadius: widget.borderRadius != null
                ? BorderRadius.circular(widget.borderRadius!)
                : AppSizes.r12,
            border: widget.borderColor != null
                ? Border.all(
                    color: widget.borderColor!,
                    width: widget.borderWidth ?? AppSizes.p1,
                  )
                : null,
            boxShadow: widget.hasShadow
                ? [
                    BoxShadow(
                      color: AppColors.shadow(context).withOpacity(0.1),
                      blurRadius: AppSizes.shadowBlur,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          );
      }
    }

    EdgeInsets getPadding() {
      switch (widget.type) {
        case ButtonType.gradient:
        case ButtonType.outline:
          return const EdgeInsets.symmetric(
              horizontal: AppSizes.p24, vertical: AppSizes.p14);
        case ButtonType.card:
          return EdgeInsets.all(AppSizes.p12);
      }
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: widget.width,
          height: widget.height,
          padding: getPadding(),
          constraints: BoxConstraints(
            minHeight: widget.height ??
                (widget.type == ButtonType.gradient
                    ? AppSizes.buttonHeightS
                    : AppSizes.p32),
            minWidth: 0,
            maxWidth: widget.width ?? double.infinity,
          ),
          decoration: getDecoration(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return FittedBox(
                fit: BoxFit.scaleDown,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth,
                  ),
                  child: buildContent(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
