import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/design/atoms/profile_avatar.dart';
import 'package:my_portfolio/design/molecules/certificate_card.dart';
import 'package:my_portfolio/design/molecules/quote_card.dart';
import 'package:my_portfolio/design/molecules/tech_icon_card.dart';
import 'package:my_portfolio/design/molecules/text_card.dart';
import 'package:my_portfolio/design/organisms/journey_timeline.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Animation<Offset>> _slideAnims = [];
  final List<Animation<double>> _fadeAnims = [];
  final int _itemCount = 11;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    for (int i = 0; i < _itemCount; i++) {
      final start = i / _itemCount;
      final end = (i + 1) / _itemCount;
      _slideAnims.add(
        Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(
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

  Widget _animItem(int index, Widget child) {
    return SlideTransition(
      position: _slideAnims[index],
      child: FadeTransition(opacity: _fadeAnims[index], child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isSmall = width < 800;
        // Responsive horizontal padding & vertical spacing
        final horizontalPadding = isSmall ? AppSizes.p16 : AppSizes.p120;
        final verticalPadding = isSmall ? AppSizes.p32 : AppSizes.p80;
        // Responsive avatar size for About screen
        final avatarSize = isSmall ? (width * 0.6).clamp(120.0, 200.0) : 320.0;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isSmall ? AppSizes.p24 : AppSizes.p48),

                // 1) Profile + Text
                _animItem(
                  1,
                  isSmall
                      ? Column(
                          children: [
                            ProfileAvatar(
                              image: const AssetImage(
                                  'assets/images/my_photo_second.jpg'),
                              showBadge: true,
                              badgeTags: [
                                AppLocalizations.of(context)!.mobileDeveloper,
                                AppLocalizations.of(context)!.flutter,
                                AppLocalizations.of(context)!.firebase
                              ],
                              showBorder: false,
                              size: avatarSize,
                            ),
                            const SizedBox(height: AppSizes.p24),
                            TextCard(
                                text:
                                    AppLocalizations.of(context)!.aboutMeText),
                          ],
                        )
                      : Row(
                          children: [
                            ProfileAvatar(
                              image: const AssetImage(
                                  'assets/images/my_photo_second.jpg'),
                              showBadge: true,
                              badgeTags: [
                                AppLocalizations.of(context)!.mobileDeveloper,
                                AppLocalizations.of(context)!.flutter,
                                AppLocalizations.of(context)!.firebase
                              ],
                              showBorder: false,
                              size: avatarSize,
                            ),
                            const SizedBox(width: AppSizes.p32),
                            Expanded(
                                child: TextCard(
                                    text: AppLocalizations.of(context)!
                                        .aboutMeText)),
                          ],
                        ),
                ),

                SizedBox(height: isSmall ? AppSizes.p32 : AppSizes.p64),

                // 2) Technologies Title
                _animItem(
                  2,
                  Text(
                    AppLocalizations.of(context)!.technologiesIUse,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: AppSizes.fontXL,
                      fontWeight: AppSizes.fontWeightSemiBold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.p24),

                // 3) Tech Icons
                _animItem(
                  3,
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppSizes.p20,
                    runSpacing: AppSizes.p16,
                    children: [
                      TechIconCard(
                          iconPath: 'assets/icons/flutter_icon.png',
                          label: AppLocalizations.of(context)!.flutter),
                      TechIconCard(
                          iconPath: 'assets/icons/dart_icon.png',
                          label: AppLocalizations.of(context)!.dart),
                      TechIconCard(
                          iconPath: 'assets/icons/kotlin_icon.png',
                          label: AppLocalizations.of(context)!.kotlin),
                      TechIconCard(
                          iconPath: 'assets/icons/firebase_icon.png',
                          label: AppLocalizations.of(context)!.firebase),
                      TechIconCard(
                          iconPath: 'assets/icons/git_icon.png',
                          label: AppLocalizations.of(context)!.git),
                      TechIconCard(
                          iconPath: 'assets/icons/figma_icon.png',
                          label: AppLocalizations.of(context)!.figma),
                      TechIconCard(
                          iconPath: 'assets/icons/hive_icon.png',
                          label: AppLocalizations.of(context)!.hive),
                      TechIconCard(
                          iconPath: 'assets/icons/riverpod_icon.png',
                          label: AppLocalizations.of(context)!.riverpod),
                    ],
                  ),
                ),

                SizedBox(height: isSmall ? AppSizes.p32 : AppSizes.p64),

                // 4) Journey Title
                _animItem(
                  4,
                  Text(
                    AppLocalizations.of(context)!.myJourney,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: AppSizes.fontXL,
                      fontWeight: AppSizes.fontWeightSemiBold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.p24),

                // 5) Journey Timeline
                _animItem(5, JourneyTimeline()),

                SizedBox(height: isSmall ? AppSizes.p32 : AppSizes.p64),

                // 6) Certificates Title
                _animItem(
                  6,
                  Text(
                    AppLocalizations.of(context)!.certificatesAndAchievements,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: AppSizes.fontXL,
                      fontWeight: AppSizes.fontWeightSemiBold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.p24),

                // 7) Certificate Cards (first row)
                _animItem(
                  7,
                  LayoutBuilder(builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    // Kaç sütun?
                    final columns = screenWidth >= 1200
                        ? 3
                        : screenWidth >= 800
                            ? 2
                            : 1;
                    final spacing = AppSizes.p24;
                    final totalSpacing = spacing * (columns - 1);
                    final cardWidth = (screenWidth - totalSpacing) / columns;

                    final firstRow = [
                      CertificateCard(
                        icon: FontAwesomeIcons.lightbulb,
                        iconColor: AppColors.primaryblue,
                        title: AppLocalizations.of(context)!.ideathon,
                        subtitle: AppLocalizations.of(context)!
                            .googleGameAndAppAcademy,
                        description:
                            AppLocalizations.of(context)!.ideathonDescription,
                        year: "2024",
                        yearColor: AppColors.primaryblue,
                      ),
                      CertificateCard(
                        icon: FontAwesomeIcons.rocket,
                        iconColor: AppColors.certOrange,
                        title: AppLocalizations.of(context)!.appJam,
                        subtitle: AppLocalizations.of(context)!
                            .googleGameAndAppAcademy,
                        description:
                            AppLocalizations.of(context)!.appJamDescription,
                        year: "2024",
                        yearColor: AppColors.certOrange,
                      ),
                      CertificateCard(
                        icon: FontAwesomeIcons.robot,
                        iconColor: AppColors.certGreen,
                        title: AppLocalizations.of(context)!.aiAppJam,
                        subtitle: AppLocalizations.of(context)!
                            .googleGameAndAppAcademy,
                        description:
                            AppLocalizations.of(context)!.aiAppJamDescription,
                        year: "2024",
                        yearColor: AppColors.certGreen,
                      ),
                    ];

                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: spacing,
                      runSpacing: spacing,
                      children: firstRow.map((card) {
                        return SizedBox(
                          width: cardWidth,
                          child: card,
                        );
                      }).toList(),
                    );
                  }),
                ),

                SizedBox(height: AppSizes.p24),

                // 8) Sertifika Kartları—ikinci grup
                _animItem(
                  8,
                  LayoutBuilder(builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    final columns = screenWidth >= 1200
                        ? 3
                        : screenWidth >= 800
                            ? 2
                            : 1;
                    final spacing = AppSizes.p24;
                    final totalSpacing = spacing * (columns - 1);
                    final cardWidth = (screenWidth - totalSpacing) / columns;

                    final secondRow = [
                      CertificateCard(
                        icon: FontAwesomeIcons.clipboardCheck,
                        iconColor: AppColors.certLightBlue,
                        title: AppLocalizations.of(context)!.projectManager,
                        subtitle: AppLocalizations.of(context)!.google,
                        description: AppLocalizations.of(context)!
                            .projectManagerDescription,
                        year: "2024",
                        yearColor: AppColors.certLightBlue,
                      ),
                      CertificateCard(
                        icon: FontAwesomeIcons.code,
                        iconColor: AppColors.certDarkBlue,
                        title: AppLocalizations.of(context)!.dartProgramming,
                        subtitle: AppLocalizations.of(context)!.btkAcademy,
                        description:
                            AppLocalizations.of(context)!.dartDescription,
                        year: "2024",
                        yearColor: AppColors.certDarkBlue,
                      ),
                      CertificateCard(
                        icon: FontAwesomeIcons.graduationCap,
                        iconColor: AppColors.certYellow,
                        title: AppLocalizations.of(context)!.bootcamp,
                        subtitle: AppLocalizations.of(context)!
                            .googleGameAndAppAcademy,
                        description:
                            AppLocalizations.of(context)!.bootcampDescription,
                        year: "2024",
                        yearColor: AppColors.certYellow,
                      ),
                    ];

                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: spacing,
                      runSpacing: spacing,
                      children: secondRow.map((card) {
                        return SizedBox(
                          width: cardWidth,
                          child: card,
                        );
                      }).toList(),
                    );
                  }),
                ),

                SizedBox(height: isSmall ? AppSizes.p32 : AppSizes.p40),

                // 9) Quote
                _animItem(
                  9,
                  QuoteCard(
                    quote: AppLocalizations.of(context)!.codeQuote,
                  ),
                ),

                SizedBox(height: isSmall ? AppSizes.p32 : AppSizes.p48),
              ],
            ),
          ),
        );
      },
    );
  }
}
