import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class TextCard extends StatelessWidget {
  /// Kartın içinde gösterilecek metin
  final String text;

  const TextCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final double maxWidth = 500;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: screenWidth > maxWidth ? maxWidth : screenWidth * 0.9,
        // Beyaz zemin, yuvarlak köşeler ve gölge efektleri
        decoration: BoxDecoration(
          color: AppColors.card(context),
          borderRadius: AppSizes.r16,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        // İçerik ile kenarlar arasındaki boşluk
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            height: 1.5, // Satırlar arası boşluk
            color: AppColors.textPrimary(context), // Koyu gri ton
          ),
        ),
      ),
    );
  }
}
