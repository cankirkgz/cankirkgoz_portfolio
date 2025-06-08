import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/design/atoms/animated_title.dart';
import 'package:my_portfolio/design/atoms/custom_badge.dart';
import 'package:my_portfolio/design/atoms/profile_avatar.dart';
import 'package:my_portfolio/design/atoms/rounded_button.dart';
import 'package:my_portfolio/design/atoms/scroll_indicator.dart';
import 'package:my_portfolio/design/atoms/section_title.dart';
import 'package:my_portfolio/design/atoms/subtitle_text.dart';
import 'package:my_portfolio/design/molecules/floating_bubbles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onProjectsTap;
  const HomeScreen({Key? key, this.onProjectsTap}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<Offset>> _slideAnims = [];
  final List<Animation<double>> _fadeAnims = [];
  final int _itemCount = 8;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    for (int i = 0; i < _itemCount; i++) {
      final start = i / _itemCount;
      final end = (i + 1) / _itemCount;
      _slideAnims.add(
        Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        ),
      );
      _fadeAnims.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeIn),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimated({required int index, required Widget child}) {
    return SlideTransition(
      position: _slideAnims[index],
      child: FadeTransition(opacity: _fadeAnims[index], child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          const FloatingBubbles(),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final isTiny = width < 600;
              final isLarge = width >= 1024;
              final avatarSize = (isTiny
                      ? width * 0.6
                      : width < 1024
                          ? width * 0.4
                          : width * 0.3)
                  .clamp(150.0, 400.0);

              final horizontalPadding = isLarge ? AppSizes.p128 : AppSizes.p32;

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: isLarge
                        ? _buildDesktopLayout(avatarSize)
                        : _buildMobileLayout(avatarSize),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: AppSizes.p16,
            left: 0,
            right: 0,
            child: Center(
              child: _buildAnimated(
                index: 7,
                child: const ScrollIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildMobileLayout(double avatarSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppSizes.p32),
        Center(
          child: _buildAnimated(
            index: 6,
            child: ProfileAvatar(
              image: const AssetImage('assets/images/my_photo_first.JPG'),
              showBorder: true,
              size: avatarSize,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.p32),
        _buildContent(isWide: false),
      ],
    );
  }

  _buildDesktopLayout(double avatarSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 2, child: _buildContent(isWide: true)),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: _buildAnimated(
              index: 6,
              child: ProfileAvatar(
                image: const AssetImage('assets/images/my_photo_first.JPG'),
                showBorder: true,
                size: avatarSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent({required bool isWide}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        _buildAnimated(
          index: 0,
          child: Align(
            alignment: isWide ? Alignment.centerLeft : Alignment.center,
            child: CustomBadge(
              text: AppLocalizations.of(context)!.currentlyDeveloping,
              backgroundColor: AppColors.successLight,
              dotColor: AppColors.success,
              textColor: AppColors.successDark,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.p16),
        _buildAnimated(
          index: 1,
          child: SectionTitle(
            title: AppLocalizations.of(context)!.hello,
            style: const TextStyle(
              fontSize: AppSizes.fontHuge,
              fontWeight: AppSizes.fontWeightBold,
            ),
            textAlign: isWide ? TextAlign.left : TextAlign.center,
          ),
        ),
        _buildAnimated(index: 2, child: const AnimatedTitle()),
        const SizedBox(height: AppSizes.p16),
        _buildAnimated(
          index: 3,
          child: RichSubtitleText(
            text: AppLocalizations.of(context)!.aboutMe,
            highlights: const {
              'Flutter': AppColors.blueText,
              'Kotlin': AppColors.purpleText,
              'Firebase': AppColors.pinkText,
            },
            textAlign: isWide ? TextAlign.left : TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSizes.p32),
        _buildAnimated(
          index: 4,
          child: Align(
            alignment: isWide ? Alignment.centerLeft : Alignment.center,
            child: Wrap(
              spacing: AppSizes.p16,
              runSpacing: AppSizes.p24,
              alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
              children: [
                RoundedButton(
                  firstText: AppLocalizations.of(context)!.viewAllProjects,
                  icon: 'assets/icons/rocket.png',
                  type: ButtonType.gradient,
                  onPressed: () {
                    widget.onProjectsTap?.call();
                  },
                ),
                RoundedButton(
                  firstText: AppLocalizations.of(context)!.downloadCV,
                  icon: 'assets/icons/download.png',
                  type: ButtonType.outline,
                  onPressed: () {
                    final anchor = html.AnchorElement(
                      href:
                          'assets/files/mcankirkgoz-mobiledeveloper-resume.pdf',
                    )
                      ..setAttribute(
                          'download', 'mcankirkgoz-mobiledeveloper-resume.pdf')
                      ..click();
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.p32),
        _buildAnimated(
          index: 5,
          child: Align(
            alignment: isWide ? Alignment.centerLeft : Alignment.center,
            child: RoundedButton(
              firstText: AppLocalizations.of(context)!.codingPlaylist,
              icon: 'assets/icons/spotify.png',
              type: ButtonType.card,
              onPressed: () {},
              textColor: Colors.black,
              rightIcon: 'assets/icons/music.png',
              hasShadow: true,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.p32),
      ],
    );
  }
}
