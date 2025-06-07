import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class RichSubtitleText extends StatelessWidget {
  final String text;
  final Map<String, Color> highlights;
  final TextAlign textAlign;

  const RichSubtitleText({
    super.key,
    required this.text,
    required this.highlights,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: words.map((word) {
          final cleanWord =
              word.replaceAll(RegExp(r'[^\w]'), ''); // Noktalama ayıklanır
          final matchedColor = highlights[cleanWord];

          return TextSpan(
            text: '$word ',
            style: TextStyle(
              fontSize: AppSizes.fontL,
              fontWeight: matchedColor != null
                  ? AppSizes.fontWeightBold
                  : AppSizes.fontWeightRegular,
              color: matchedColor ?? AppColors.textSecondary,
            ),
          );
        }).toList(),
      ),
    );
  }
}
