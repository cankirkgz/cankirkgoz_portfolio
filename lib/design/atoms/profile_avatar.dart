import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class ProfileAvatar extends StatelessWidget {
  final ImageProvider image;
  final bool showBadge;
  final List<String>? badgeTags;
  final bool showBorder;
  final double size;

  const ProfileAvatar({
    super.key,
    required this.image,
    this.showBadge = false,
    this.badgeTags,
    this.showBorder = true,
    this.size = 320,
  });

  @override
  Widget build(BuildContext context) {
    final double outerSize = size;
    final double imageSize = outerSize - (showBorder ? 20 : 0);

    // Ekran genişliği bazlı küçük mod kontrolü
    final isCompact = MediaQuery.of(context).size.width < 600;

    // Badge ölçüleri: normal ve compact
    final double badgeWidth = isCompact
        ? outerSize * 0.5 // compact iken daha dar
        : outerSize * 0.7; // normalde %70

    final double padH = isCompact ? 8 : 16;
    final double padV = isCompact ? 6 : 12;

    // Yazı boyutu: compact modda küçük, normalde orijinal 14
    final double fontSize = isCompact ? 12 : 14;

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          if (showBorder)
            Positioned(
              top: 0,
              child: Container(
                width: outerSize,
                height: outerSize,
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

          // Avatar fotoğraf
          Positioned(
            top: showBorder ? (outerSize - imageSize) / 2 : 0,
            child: Container(
              width: imageSize,
              height: imageSize,
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

          // Badge
          if (showBadge && badgeTags != null && badgeTags!.isNotEmpty)
            Positioned(
              bottom: 0,
              child: Container(
                width: badgeWidth,
                padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
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
                  mainAxisSize: MainAxisSize.min,
                  children: badgeTags!.map((tag) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: padV / 2),
                      child: Text(
                        tag,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
