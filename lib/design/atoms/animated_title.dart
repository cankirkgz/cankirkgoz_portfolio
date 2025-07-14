import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/l10n/app_localizations.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${AppLocalizations.of(context)!.one} ',
          style: const TextStyle(
            fontSize: AppSizes.fontXL,
            fontWeight: AppSizes.fontWeightBold,
            color: AppColors.blackText,
          ),
        ),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: AppSizes.fontXL,
            fontWeight: AppSizes.fontWeightBold,
            color: AppColors.blueText,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            pause: const Duration(seconds: 2),
            animatedTexts: [
              TyperAnimatedText(AppLocalizations.of(context)!.problemSolver),
              TyperAnimatedText(AppLocalizations.of(context)!.techEnthusiast),
              TyperAnimatedText(AppLocalizations.of(context)!.flutterDeveloper),
            ],
            onTap: () {
              // isteğe bağlı tıklama efekti
            },
          ),
        ),
      ],
    );
  }
}
