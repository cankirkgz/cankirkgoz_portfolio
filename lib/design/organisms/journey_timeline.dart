import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/design/molecules/timeline_item.dart';

class JourneyTimeline extends StatelessWidget {
  const JourneyTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dikey gradient çizgi (timeline)
        Positioned(
          left: 24, // TimelineItem'daki yıl metni ile hizalı
          top: 0,
          bottom: 0,
          child: Container(
            width: 4, // Çizgi kalınlığı
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.blueText,
                  AppColors.purpleText,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 1.0], // Düz geçiş
              ),
            ),
          ),
        ),

        // Timeline öğeleri
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimelineItem(
              year: '2025',
              title: AppLocalizations.of(context)!.wedlyTitle,
              description:
                  AppLocalizations.of(context)!.wedlyJourneyDescription,
              color: AppColors.blueText,
            ),
            TimelineItem(
              year: '2024',
              title: AppLocalizations.of(context)!.ternaiTitle,
              description:
                  AppLocalizations.of(context)!.ternaiJourneyDescription,
              color: AppColors.blueText,
            ),
            TimelineItem(
              year: '2024',
              title: AppLocalizations.of(context)!.googleAcademyTitle,
              description:
                  AppLocalizations.of(context)!.googleAcademyDescription,
              color: AppColors.blueText,
            ),
            TimelineItem(
              year: '2022',
              title: AppLocalizations.of(context)!.school42Title,
              description: AppLocalizations.of(context)!.school42Description,
              color: AppColors.purpleText,
            ),
            TimelineItem(
              year: '2018 – 2024',
              title: AppLocalizations.of(context)!.mathDegreeTitle,
              description: AppLocalizations.of(context)!.mathDegreeDescription,
              color: AppColors.blueText,
            ),
          ],
        ),
      ],
    );
  }
}
