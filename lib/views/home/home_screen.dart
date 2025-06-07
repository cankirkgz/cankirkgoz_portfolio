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
  final int _itemCount = 8; // number of animated widgets

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    // build staggered animations
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
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppSizes.p128),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildAnimated(
                              index: 0,
                              child: CustomBadge(
                                text:
                                    'Şu anda Flutter ile bir yapay zeka uygulaması geliştiriyorum',
                                backgroundColor: AppColors.successLight,
                                dotColor: AppColors.success,
                                textColor: AppColors.successDark,
                              ),
                            ),
                            const SizedBox(height: AppSizes.p16),
                            _buildAnimated(
                              index: 1,
                              child: SectionTitle(
                                title: 'Merhaba, Ben Can 👋',
                                style: TextStyle(
                                  fontSize: AppSizes.fontHuge,
                                  fontWeight: AppSizes.fontWeightBold,
                                ),
                              ),
                            ),
                            _buildAnimated(
                              index: 2,
                              child: const AnimatedTitle(),
                            ),
                            const SizedBox(height: AppSizes.p16),
                            _buildAnimated(
                              index: 3,
                              child: RichSubtitleText(
                                text:
                                    'Flutter, Kotlin ve Firebase \nkullanarak sade ve kullanıcı odaklı uygulamalar geliştirmeye tutkulu biriyim.',
                                highlights: {
                                  'Flutter': AppColors.blueText,
                                  'Kotlin': AppColors.purpleText,
                                  'Firebase': AppColors.pinkText,
                                },
                              ),
                            ),
                            const SizedBox(height: AppSizes.p32),
                            _buildAnimated(
                              index: 4,
                              child: Row(
                                children: [
                                  RoundedButton(
                                    firstText: 'Projelerime Göz At',
                                    icon: 'assets/icons/rocket.png',
                                    type: ButtonType.gradient,
                                    onPressed: () {
                                      widget.onProjectsTap?.call();
                                    },
                                  ),
                                  const SizedBox(width: AppSizes.p16),
                                  RoundedButton(
                                    firstText: "CV'mi İndir",
                                    icon: 'assets/icons/download.png',
                                    type: ButtonType.outline,
                                    onPressed: () {
                                      final anchor = html.AnchorElement(
                                        href:
                                            'assets/files/mcankirkgoz-mobiledeveloper-resume.pdf',
                                      )
                                        ..setAttribute('download',
                                            'mcankirkgoz-mobiledeveloper-resume.pdf')
                                        ..click();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSizes.p32),
                            _buildAnimated(
                              index: 5,
                              child: RoundedButton(
                                firstText: 'Kodlama Listem',
                                icon: 'assets/icons/spotify.png',
                                type: ButtonType.card,
                                onPressed: () {},
                                textColor: Colors.black,
                                rightIcon: 'assets/icons/music.png',
                                hasShadow: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: AppSizes.p128),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: _buildAnimated(
                            index: 6,
                            child: const ProfileAvatar(
                              image: AssetImage(
                                  'assets/images/my_photo_first.JPG'),
                              showBorder: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
}
