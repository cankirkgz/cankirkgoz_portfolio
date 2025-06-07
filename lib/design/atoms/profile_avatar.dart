import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class ProfileAvatar extends StatelessWidget {
  final ImageProvider image;
  final bool showBadge; // Alttaki mavi baloncuk
  final List<String>? badgeTags;
  final bool showBorder; // Dıştaki beyaz/gradient kenar

  const ProfileAvatar({
    super.key,
    required this.image,
    this.showBadge = false,
    this.badgeTags,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    const double outerSize = 320;
    const double imageSize = 300; // outerSize - 2*border
    // const double badgeHeight = 60; // Artık taşma olmayacak
    // double totalHeight = outerSize + (showBadge ? badgeHeight : 0);

    return SizedBox(
      height: outerSize,
      width: outerSize,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // ── 1) Beyaz border ve dış gölge (showBorder true ise)
          if (showBorder)
            Positioned(
              top: 0,
              child: Container(
                height: outerSize,
                width: outerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
            ),

          // ── 2) Ana avatar (yuvarlak fotoğraf, border yoksa kendi gölgesi)
          Positioned(
            top: (showBorder ? (outerSize - imageSize) / 2 : 0),
            child: Container(
              height: imageSize,
              width: imageSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: image, fit: BoxFit.cover),
                boxShadow: showBorder
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
              ),
            ),
          ),

          // ── 3) Alttaki etiket balonu (opsiyonel, avatar'ın tam altında ortalanmış)
          if (showBadge && badgeTags != null && badgeTags!.isNotEmpty)
            Positioned(
              bottom: 0,
              child: Container(
                width: outerSize * 0.7, // Orta hizalı, genişliği ayarlanabilir
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [AppColors.blueText, AppColors.purpleText],
                  ),
                  borderRadius: AppSizes.r16,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: badgeTags!
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            tag,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
