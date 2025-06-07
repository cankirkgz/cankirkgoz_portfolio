import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class TimelineItem extends StatelessWidget {
  final String year;
  final String title;
  final String description;
  final Color color;

  const TimelineItem({
    super.key,
    required this.year,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    const double markerSize = 24;
    const double innerDotSize = 16;
    const double markerLeftPosition = 12; // Marker'ın soldan pozisyonu

    return Stack(
      children: [
        // Kart
        Padding(
          padding: const EdgeInsets.only(left: markerSize + markerLeftPosition),
          child: Card(
            elevation: 1,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    year,
                    style: TextStyle(
                      fontWeight: AppSizes.fontWeightMedium,
                      fontSize: AppSizes.fontS,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: AppSizes.fontWeightBold,
                      fontSize: AppSizes.fontM,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontWeight: AppSizes.fontWeightRegular,
                      fontSize: AppSizes.fontS,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Marker (beyaz dış, renkli iç)
        Positioned(
          left: markerLeftPosition,
          top: 0,
          bottom: 0,
          child: Center(
            child: Container(
              width: markerSize,
              height: markerSize,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: innerDotSize,
                  height: innerDotSize,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
