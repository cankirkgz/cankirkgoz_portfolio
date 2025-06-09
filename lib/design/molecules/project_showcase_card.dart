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
        final width = constraints.maxWidth;
        // Define breakpoints
        const largeDesktop = 1360.0;
        const desktop = 1000.0;
        const tablet = 600.0;

        double cardWidth;
        Axis layoutAxis = Axis.horizontal;
        double fontScale = 1.0;

        // Determine layout settings per breakpoint
        if (width >= largeDesktop) {
          // extra-large: two cards side by side at 45%
          cardWidth = width * 0.45;
          layoutAxis = Axis.horizontal;
          fontScale = 1.0;
        } else if (width >= desktop) {
          // medium desktop: cards at 50%
          cardWidth = width * 0.5;
          layoutAxis = Axis.horizontal;
          fontScale = 0.95;
        } else if (width >= tablet) {
          // tablet: full width, horizontal content
          cardWidth = width;
          layoutAxis = Axis.horizontal;
          fontScale = 0.9;
        } else {
          // mobile: full width, vertical stack
          cardWidth = width;
          layoutAxis = Axis.vertical;
          fontScale = 0.85;
        }

        Widget content;
        if (layoutAxis == Axis.horizontal) {
          content = Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImage(),
              SizedBox(width: AppSizes.p16),
              Expanded(child: _buildTextAndButtons(fontScale)),
            ],
          );
        } else {
          content = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImage(),
              SizedBox(height: AppSizes.p12),
              Expanded(child: _buildTextAndButtons(fontScale)),
            ],
          );
        }

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: cardWidth,
            constraints: BoxConstraints(minHeight: 450),
            margin: EdgeInsets.all(AppSizes.p12),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground(context),
              borderRadius: AppSizes.r16,
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? AppColors.blueText.withOpacity(0.2)
                      : AppColors.shadow(context).withOpacity(0.05),
                  blurRadius: _isHovered ? AppSizes.p20 : AppSizes.shadowBlur,
                  offset: Offset(0, AppSizes.p6),
                ),
              ],
            ),
            transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
            child: Padding(
              padding: EdgeInsets.all(AppSizes.p16 * fontScale),
              child: IntrinsicHeight(child: content),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: AppSizes.r12,
      child: SizedBox(
        width: AppSizes.p256,
        height: AppSizes.p256,
        child: Image.asset(widget.imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildTextAndButtons(double fontScale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Badge
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: AppSizes.fontXL * fontScale,
                  fontWeight: AppSizes.fontWeightBold,
                  color: AppColors.textPrimary(context),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: AppSizes.p8),
            CustomBadge(
              text: widget.badgeText,
              backgroundColor: widget.badgeColor,
              textColor: Colors.white,
              showDot: false,
            ),
          ],
        ),
        SizedBox(height: AppSizes.p12 * fontScale),
        // Description with tooltip
        Tooltip(
          preferBelow: true,
          decoration: BoxDecoration(
            color: AppColors.card(context).withOpacity(0.9),
            borderRadius: AppSizes.r8,
          ),
          richMessage: TextSpan(
            children: [
              WidgetSpan(
                child: Container(
                  width: AppSizes.p200,
                  padding: EdgeInsets.all(AppSizes.p8),
                  child: Text(widget.description,
                      style: TextStyle(
                        fontSize: AppSizes.fontS * fontScale,
                        color: AppColors.textPrimary(context),
                      )),
                ),
              ),
            ],
          ),
          child: Text(
            widget.description,
            style: TextStyle(
              fontSize: AppSizes.fontM * fontScale,
              fontWeight: AppSizes.fontWeightRegular,
              color: AppColors.textSecondary(context),
            ),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: AppSizes.p4 * fontScale),
        // Tech tags
        Wrap(
          spacing: AppSizes.p8,
          runSpacing: AppSizes.p8,
          children: List.generate(
            widget.techTags.length,
            (i) => CustomBadge(
              text: widget.techTags[i],
              backgroundColor: widget.techTagColors[i].withOpacity(0.15),
              textColor: widget.techTagColors[i],
              showDot: false,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.p8,
                vertical: AppSizes.p4,
              ),
              borderRadius: AppSizes.r8.bottomLeft.x,
            ),
          ),
        ),
        SizedBox(height: AppSizes.p4 * fontScale),

        Spacer(),
        // Buttons row at bottom
        Row(
          children: [
            Expanded(
              child: RoundedButton(
                firstText: widget.button1Text,
                secondText: widget.button1SecondText,
                icon: 'assets/icons/share_icon.png',
                onPressed: widget.onButton1Pressed,
                type: ButtonType.gradient,
                gradientColors: [
                  AppColors.primaryblue,
                  AppColors.primaryPurple,
                ],
                height: widget.buttonHeight,
              ),
            ),
            SizedBox(width: AppSizes.p12),
            Expanded(
              child: RoundedButton(
                firstText: widget.button2Text,
                icon: 'assets/icons/github_icon.png',
                onPressed: widget.onButton2Pressed,
                type: ButtonType.outline,
                gradientColors: [
                  AppColors.primaryblue,
                  AppColors.primaryPurple,
                ],
                height: widget.buttonHeight,
                textColor: AppColors.textPrimary(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
