import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Bir ',
          style: TextStyle(
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
              TyperAnimatedText('Problem Çözücü'),
              TyperAnimatedText('Teknoloji Tutkunu'),
              TyperAnimatedText('Flutter Geliştiricisi'),
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
