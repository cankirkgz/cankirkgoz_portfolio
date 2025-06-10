import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/design/atoms/rounded_button.dart';
import 'package:my_portfolio/design/molecules/skill_level_card.dart';
import 'package:my_portfolio/design/molecules/framework_card.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({Key? key}) : super(key: key);

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<Offset>> _slideAnims = [];
  final List<Animation<double>> _fadeAnims = [];
  final int _itemCount = 12;

  String _currentFilter = 'all';
  final Duration _filterAnimationDuration = const Duration(milliseconds: 500);
  final Curve _filterAnimationCurve = Curves.easeInOut;

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
        Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(
          CurvedAnimation(
              parent: _controller,
              curve: Interval(start, end, curve: Curves.easeOut)),
        ),
      );
      _fadeAnims.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: _controller,
              curve: Interval(start, end, curve: Curves.easeIn)),
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

  List<Widget> _getFilteredSkillCards() {
    if (_currentFilter == "all") {
      return [
        Row(
          children: [
            Expanded(
              child: SkillLevelCard(
                skillName: AppLocalizations.of(context)!.flutter,
                skillLevel:
                    AppLocalizations.of(context)!.skillLevelIntermediatePlus,
                percentage: 65,
                color: AppColors.primaryblue,
                iconPath: 'assets/icons/flutter_icon.png',
                gradientColors: const [
                  AppColors.blueText,
                  AppColors.purpleText
                ],
              ),
            ),
            const SizedBox(width: AppSizes.p16),
            Expanded(
              child: SkillLevelCard(
                skillName: AppLocalizations.of(context)!.dart,
                skillLevel:
                    AppLocalizations.of(context)!.skillLevelIntermediatePlus,
                percentage: 65,
                color: AppColors.primaryblue,
                iconPath: 'assets/icons/dart_icon.png',
                gradientColors: const [
                  AppColors.blueText,
                  AppColors.purpleText
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.p16),
        Row(
          children: [
            Expanded(
              child: SkillLevelCard(
                skillName: AppLocalizations.of(context)!.firebase,
                skillLevel:
                    AppLocalizations.of(context)!.skillLevelIntermediate,
                percentage: 55,
                color: AppColors.skillOrange,
                iconPath: 'assets/icons/firebase_icon.png',
                gradientColors: const [
                  AppColors.skillDeepOrange,
                  AppColors.skillOrangeAccent
                ],
              ),
            ),
            const SizedBox(width: AppSizes.p16),
            Expanded(
              child: SkillLevelCard(
                skillName: AppLocalizations.of(context)!.kotlin,
                skillLevel: AppLocalizations.of(context)!.skillLevelBeginner,
                percentage: 30,
                color: AppColors.skillPurple,
                iconPath: 'assets/icons/kotlin_icon.png',
              ),
            ),
          ],
        ),
      ];
    } else if (_currentFilter == "beginner") {
      return [
        Row(
          children: [
            Expanded(
              child: SkillLevelCard(
                skillName: AppLocalizations.of(context)!.kotlin,
                skillLevel: AppLocalizations.of(context)!.skillLevelBeginner,
                percentage: 30,
                color: AppColors.skillPurple,
                iconPath: 'assets/icons/kotlin_icon.png',
              ),
            ),
            const SizedBox(width: AppSizes.p16),
            Expanded(child: Container()),
          ],
        ),
      ];
    } else if (_currentFilter == "intermediate") {
      return [
        Row(
          children: [
            Expanded(
              child: SkillLevelCard(
                skillName: AppLocalizations.of(context)!.flutter,
                skillLevel:
                    AppLocalizations.of(context)!.skillLevelIntermediatePlus,
                percentage: 65,
                color: AppColors.primaryblue,
                iconPath: 'assets/icons/flutter_icon.png',
                gradientColors: const [
                  AppColors.blueText,
                  AppColors.purpleText
                ],
              ),
            ),
            const SizedBox(width: AppSizes.p16),
            Expanded(
              child: SkillLevelCard(
                skillName: AppLocalizations.of(context)!.dart,
                skillLevel:
                    AppLocalizations.of(context)!.skillLevelIntermediatePlus,
                percentage: 65,
                color: AppColors.primaryblue,
                iconPath: 'assets/icons/dart_icon.png',
                gradientColors: const [
                  AppColors.blueText,
                  AppColors.purpleText
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.p16),
        Row(
          children: [
            Expanded(
              child: SkillLevelCard(
                skillName: AppLocalizations.of(context)!.firebase,
                skillLevel:
                    AppLocalizations.of(context)!.skillLevelIntermediate,
                percentage: 55,
                color: AppColors.skillOrange,
                iconPath: 'assets/icons/firebase_icon.png',
                gradientColors: const [
                  AppColors.skillDeepOrange,
                  AppColors.skillOrangeAccent
                ],
              ),
            ),
            const SizedBox(width: AppSizes.p16),
            Expanded(child: Container()),
          ],
        ),
      ];
    } else if (_currentFilter == "expert") {
      return [
        Center(
          child: Text(
            AppLocalizations.of(context)!.expertSkillsNotAdded,
            style: const TextStyle(
              fontSize: AppSizes.fontL,
              color: AppColors.darkText,
            ),
          ),
        ),
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    const double itemGap = AppSizes.p16;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground(context),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.p24, vertical: AppSizes.p80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Başlık
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 600;
                    return _animItem(
                      0,
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.technologies,
                          style: TextStyle(
                            fontSize: AppSizes.fontXXXXL,
                            fontWeight: AppSizes.fontWeightBold,
                            color: AppColors.textPrimary(context),
                          ),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSizes.p8),
                // Alt başlık
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 600;
                    return _animItem(
                      1,
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.technologiesSubtitle,
                          style: TextStyle(
                            fontSize: AppSizes.fontL,
                            fontWeight: AppSizes.fontWeightRegular,
                            color: AppColors.textSecondary(context),
                          ),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSizes.p48),

                // Filtre butonları
                _animItem(
                  2,
                  Center(
                    child: Wrap(
                      spacing: 30,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        RoundedButton(
                          firstText: AppLocalizations.of(context)!.allSkills,
                          onPressed: () {
                            setState(() {
                              _currentFilter = "all";
                            });
                          },
                          type: _currentFilter == "all"
                              ? ButtonType.gradient
                              : ButtonType.outline,
                          borderRadius: 9999,
                        ),
                        RoundedButton(
                          firstText: AppLocalizations.of(context)!.beginner,
                          onPressed: () {
                            setState(() {
                              _currentFilter = "beginner";
                            });
                          },
                          type: _currentFilter == "beginner"
                              ? ButtonType.gradient
                              : ButtonType.outline,
                          borderRadius: 9999,
                        ),
                        RoundedButton(
                          firstText: AppLocalizations.of(context)!.intermediate,
                          onPressed: () {
                            setState(() {
                              _currentFilter = "intermediate";
                            });
                          },
                          type: _currentFilter == "intermediate"
                              ? ButtonType.gradient
                              : ButtonType.outline,
                          borderRadius: 9999,
                        ),
                        RoundedButton(
                          firstText: AppLocalizations.of(context)!.expert,
                          onPressed: () {
                            setState(() {
                              _currentFilter = "expert";
                            });
                          },
                          type: _currentFilter == "expert"
                              ? ButtonType.gradient
                              : ButtonType.outline,
                          borderRadius: 9999,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.p48),

                // Featured Projects başlığı
                _animItem(
                  3,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/code_icon.png',
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.of(context)!.featuredSkills,
                        style: TextStyle(
                          fontSize: AppSizes.fontXL,
                          fontWeight: AppSizes.fontWeightSemiBold,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.p24),

                // Filtrelenmiş yetenek kartları (Animasyonlu)
                _animItem(
                  4,
                  AnimatedSwitcher(
                    duration: _filterAnimationDuration,
                    switchInCurve: _filterAnimationCurve,
                    switchOutCurve: _filterAnimationCurve,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.vertical,
                          axisAlignment: -1,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      key: ValueKey<String>(_currentFilter),
                      children: _getFilteredSkillCards(),
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.p48),

                // Diğer bölümler aynı şekilde devam eder...
                _animItem(
                  5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/framework_icon.png',
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.of(context)!.frameworksAndLibraries,
                        style: TextStyle(
                          fontSize: AppSizes.fontXL,
                          fontWeight: AppSizes.fontWeightSemiBold,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.p24),
                _animItem(
                  6,
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // calculate how many cards fit in one row (min width of 280)
                      int count = (constraints.maxWidth / 280).floor();
                      if (count < 1) count = 1;
                      double cardWidth =
                          (constraints.maxWidth - (count - 1) * itemGap) /
                              count;

                      return Wrap(
                        spacing: itemGap,
                        runSpacing: itemGap,
                        children: frameworkCards
                            .map((card) => SizedBox(
                                  width: cardWidth,
                                  child: card,
                                ))
                            .toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.p48),
                _animItem(
                  7,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/tools.png',
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.of(context)!.toolsAndPlatforms,
                        style: TextStyle(
                          fontSize: AppSizes.fontXL,
                          fontWeight: AppSizes.fontWeightSemiBold,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.p24),
                _animItem(
                  8,
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const double minCardWidth = 200;
                      const double gap = 16; // your itemGap

                      // figure out how many cards fit side by side
                      int itemsPerRow =
                          ((constraints.maxWidth + gap) ~/ (minCardWidth + gap))
                              .clamp(1, toolCards.length);

                      // now slice the available width equally among that many cards
                      final totalSpacing = gap * (itemsPerRow - 1);
                      final cardWidth =
                          (constraints.maxWidth - totalSpacing) / itemsPerRow;

                      return Wrap(
                        spacing: gap,
                        runSpacing: gap,
                        children: toolCards.map((card) {
                          return SizedBox(
                            width: cardWidth,
                            child: card,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.p48),
                _animItem(
                  9,
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryblue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/icons/education_icon.png',
                              height: 32,
                              width: 32,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              AppLocalizations.of(context)!.currentlyLearning,
                              style: TextStyle(
                                fontSize: AppSizes.fontL,
                                fontWeight: AppSizes.fontWeightSemiBold,
                                color: AppColors.textPrimary(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RoundedButton(
                              firstText: AppLocalizations.of(context)!.kotlin,
                              onPressed: () {},
                              type: ButtonType.outline,
                              icon: "assets/icons/kotlin_icon.png",
                              iconColor: const Color(0xFFF97316),
                              borderRadius: 999,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<FrameworkCard> get frameworkCards => [
        FrameworkCard(
          title: AppLocalizations.of(context)!.flutter,
          level: AppLocalizations.of(context)!.coreTechnology,
          iconPath: "assets/icons/phone_icon.png",
          iconBackgroundColor: const Color(0xFF2563EB),
          badgeColor: const Color(0xFF6366F1),
        ),
        FrameworkCard(
          title: AppLocalizations.of(context)!.reactNative,
          level: AppLocalizations.of(context)!.intermediateLevel,
          iconPath: "assets/icons/reactnative_icon.png",
          iconBackgroundColor: const Color(0xFF9333EA),
          badgeColor: const Color(0xFF8B5CF6),
        ),
        FrameworkCard(
          title: AppLocalizations.of(context)!.firebase,
          level: AppLocalizations.of(context)!.intermediateLevel,
          iconPath: "assets/icons/firebase_icon.png",
          iconBackgroundColor: const Color(0xFFEA580C),
          badgeColor: const Color(0xFF6366F1),
        ),
        FrameworkCard(
          title: AppLocalizations.of(context)!.riverpod,
          level: AppLocalizations.of(context)!.intermediateLevel,
          iconPath: "assets/icons/riverpod_icon.png",
          iconBackgroundColor: const Color(0xFF0D9488),
          badgeColor: const Color(0xFF8B5CF6),
        ),
      ];

  List<FrameworkCard> get toolCards => [
        FrameworkCard(
          title: AppLocalizations.of(context)!.git,
          iconPath: "assets/icons/git_icon.png",
          iconBackgroundColor: const Color(0xFF334155),
        ),
        FrameworkCard(
          title: AppLocalizations.of(context)!.github,
          iconPath: "assets/icons/github_icon.png",
          iconBackgroundColor: const Color(0xFF334155),
        ),
        FrameworkCard(
          title: AppLocalizations.of(context)!.figma,
          iconPath: "assets/icons/figma_icon.png",
          iconBackgroundColor: const Color(0xFF334155),
        ),
        FrameworkCard(
          title: AppLocalizations.of(context)!.vsCode,
          iconPath: "assets/icons/riverpod_icon.png",
          iconBackgroundColor: const Color(0xFF334155),
        ),
        FrameworkCard(
          title: AppLocalizations.of(context)!.androidStudio,
          iconPath: "assets/icons/kotlin_icon.png",
          iconBackgroundColor: const Color(0xFF334155),
        ),
      ];
}
