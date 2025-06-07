import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class CertificateCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
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
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontSize: AppSizes.fontM,
                        fontWeight: AppSizes.fontWeightSemiBold,
                        color: AppColors.darkText,
                      )),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: AppSizes.fontS,
                      fontWeight: AppSizes.fontWeightRegular,
                      color: AppColors.blackText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Tooltip(
            message: description,
            child: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppSizes.fontS,
                fontWeight: AppSizes.fontWeightRegular,
                color: AppColors.blackText,
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
                  year,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: yearColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.verified, size: 16, color: yearColor),
              ],
            ),
          )
        ],
      ),
    );
  }
}
