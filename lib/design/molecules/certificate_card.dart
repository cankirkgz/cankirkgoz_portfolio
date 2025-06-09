import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class CertificateCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String description;
  final String year;
  final Color yearColor;

  const CertificateCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.year,
    required this.yearColor,
  });

  @override
  State<CertificateCard> createState() => _CertificateCardState();
}

class _CertificateCardState extends State<CertificateCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.card(context),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.iconColor.withOpacity(0.2)
                    : AppColors.shadow(context).withOpacity(0.05),
                blurRadius: _isHovered ? 12 : 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.iconColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(widget.icon, color: widget.iconColor),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: AppSizes.fontM,
                          fontWeight: AppSizes.fontWeightSemiBold,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          fontSize: AppSizes.fontS,
                          fontWeight: AppSizes.fontWeightRegular,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Tooltip(
                message: widget.description,
                waitDuration: const Duration(milliseconds: 500),
                showDuration: const Duration(seconds: 3),
                padding: const EdgeInsets.all(AppSizes.p8),
                decoration: BoxDecoration(
                  color: AppColors.card(context).withOpacity(0.9),
                  borderRadius: AppSizes.r8,
                ),
                textStyle: TextStyle(
                  color: AppColors.textPrimary(context),
                  fontSize: AppSizes.fontS,
                ),
                child: Text(
                  widget.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppSizes.fontS,
                    fontWeight: AppSizes.fontWeightRegular,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.year,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: widget.yearColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.verified, size: 16, color: widget.yearColor),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
