import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/design/atoms/custom_badge.dart';
import 'package:my_portfolio/design/atoms/rounded_button.dart';

class ProjectShowcaseCard extends StatefulWidget {
  final String title;
  final String description;
  final String badgeText;
  final Color badgeColor;
  final String imagePath;
  final List<String> techTags;
  final List<Color> techTagColors;
  final String button1Text;
  final String? button1SecondText;
  final VoidCallback onButton1Pressed;
  final String button2Text;
  final VoidCallback onButton2Pressed;
  final double? buttonHeight;
  final String projectLanguage;

  const ProjectShowcaseCard({
    super.key,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.badgeColor,
    required this.imagePath,
    required this.techTags,
    required this.techTagColors,
    required this.button1Text,
    this.button1SecondText,
    required this.onButton1Pressed,
    required this.button2Text,
    required this.onButton2Pressed,
    this.buttonHeight,
    required this.projectLanguage,
  });

  @override
  State<ProjectShowcaseCard> createState() => _ProjectShowcaseCardState();
}

class _ProjectShowcaseCardState extends State<ProjectShowcaseCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth * 0.45;
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                minHeight: 450,
              ),
              child: Container(
                margin: AppSizes.p12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppSizes.r16,
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered
                          ? AppColors.blueText.withOpacity(0.2)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: _isHovered ? 20 : AppSizes.shadowBlur,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: AppSizes.p16,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Görsel (256x256)
                        ClipRRect(
                          borderRadius: AppSizes.r12,
                          child: SizedBox(
                            width: 256,
                            height: 256,
                            child: Image.asset(
                              widget.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: AppSizes.p16.left),

                        // İçerik kısmı
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Başlık ve Rozet
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.title,
                                      style: TextStyle(
                                        fontSize: AppSizes.fontXL,
                                        fontWeight: AppSizes.fontWeightBold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: AppSizes.p8.left),
                                  CustomBadge(
                                    text: widget.badgeText,
                                    showDot: false,
                                  ),
                                ],
                              ),
                              SizedBox(height: AppSizes.p12.top),

                              // Açıklama (maksimum 6 satır)
                              Tooltip(
                                message: null,
                                preferBelow: true,
                                padding: AppSizes.p8,
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: AppSizes.r8,
                                ),
                                waitDuration: const Duration(milliseconds: 300),
                                showDuration: const Duration(seconds: 5),
                                richMessage: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Container(
                                        width: 200,
                                        padding: AppSizes.p8,
                                        child: Text(
                                          widget.description,
                                          style: TextStyle(
                                            fontSize: AppSizes.fontS,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  widget.description,
                                  style: TextStyle(
                                    fontSize: AppSizes.fontM,
                                    fontWeight: AppSizes.fontWeightRegular,
                                    color: AppColors.blackText,
                                  ),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              // Açıklama ile etiketler arasındaki boşluk
                              SizedBox(height: AppSizes.p4.top),

                              // Teknoloji Etiketleri
                              Wrap(
                                spacing: AppSizes.p8.left,
                                runSpacing: AppSizes.p8.top,
                                children: List.generate(
                                  widget.techTags.length,
                                  (index) => CustomBadge(
                                    text: widget.techTags[index],
                                    backgroundColor: widget.techTagColors[index]
                                        .withOpacity(0.15),
                                    textColor: widget.techTagColors[index],
                                    showDot: false,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppSizes.p8.left,
                                      vertical: AppSizes.p4.top,
                                    ),
                                    borderRadius: 8,
                                  ),
                                ),
                              ),

                              Spacer(),

                              // Butonlar
                              Row(
                                children: [
                                  Expanded(
                                    child: RoundedButton(
                                      firstText: widget.button1Text,
                                      secondText: widget.button1SecondText,
                                      icon: "assets/icons/share_icon.png",
                                      onPressed: widget.onButton1Pressed,
                                      type: ButtonType.gradient,
                                      gradientColors: [
                                        AppColors.primaryblue,
                                        AppColors.primaryPurple
                                      ],
                                      height: widget.buttonHeight,
                                    ),
                                  ),
                                  SizedBox(width: AppSizes.p12.left),
                                  Expanded(
                                    child: RoundedButton(
                                      firstText: widget.button2Text,
                                      icon: "assets/icons/github_icon.png",
                                      onPressed: widget.onButton2Pressed,
                                      type: ButtonType.outline,
                                      gradientColors: [
                                        AppColors.primaryblue,
                                        AppColors.primaryPurple
                                      ],
                                      height: widget.buttonHeight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
