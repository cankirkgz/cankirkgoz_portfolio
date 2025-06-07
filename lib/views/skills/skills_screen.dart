import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 24.0;
    const double itemGap = 16.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 80.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık
                  _animItem(
                    0,
                    Center(
                      child: Text(
                        "Kullandığım Teknolojiler",
                        style: TextStyle(
                          fontSize: AppSizes.fontXXXXL,
                          fontWeight: AppSizes.fontWeightBold,
                          color: const Color(0xFF111827),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Alt başlık
                  _animItem(
                    1,
                    Center(
                      child: Text(
                        "Mobil uygulamalar geliştirmek için kullandığım teknolojiler, araçlar ve framework'ler.",
                        style: TextStyle(
                          fontSize: AppSizes.fontL,
                          fontWeight: AppSizes.fontWeightRegular,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

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
                            firstText: "Tüm Yetenekler",
                            onPressed: () {},
                            type: ButtonType.gradient,
                            borderRadius: 9999,
                          ),
                          RoundedButton(
                            firstText: "Başlangıç",
                            onPressed: () {},
                            type: ButtonType.outline,
                            borderRadius: 9999,
                          ),
                          RoundedButton(
                            firstText: "Orta Seviye",
                            onPressed: () {},
                            type: ButtonType.outline,
                            borderRadius: 9999,
                          ),
                          RoundedButton(
                            firstText: "Uzman",
                            onPressed: () {},
                            type: ButtonType.outline,
                            borderRadius: 9999,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

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
                          'Öne Çıkan Yetenekler',
                          style: TextStyle(
                            fontSize: AppSizes.fontXL,
                            fontWeight: AppSizes.fontWeightSemiBold,
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // GridView yerine Row ve Expanded kullanıyoruz
                  _animItem(
                    4,
                    Column(
                      children: [
                        // İlk satır
                        Row(
                          children: [
                            Expanded(
                              child: SkillLevelCard(
                                skillName: 'Flutter',
                                skillLevel: 'Orta+',
                                percentage: 65,
                                color: AppColors.primaryblue,
                                iconPath: 'assets/icons/flutter_icon.png',
                                gradientColors: [
                                  AppColors.blueText,
                                  AppColors.purpleText
                                ],
                              ),
                            ),
                            SizedBox(width: AppSizes.p16.left),
                            Expanded(
                              child: SkillLevelCard(
                                skillName: 'Dart',
                                skillLevel: 'Orta+',
                                percentage: 65,
                                color: AppColors.primaryblue,
                                iconPath: 'assets/icons/dart_icon.png',
                                gradientColors: [
                                  AppColors.blueText,
                                  AppColors.purpleText
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.p16.top),
                        // İkinci satır
                        Row(
                          children: [
                            Expanded(
                              child: SkillLevelCard(
                                skillName: 'Firebase',
                                skillLevel: 'Orta',
                                percentage: 55,
                                color: Colors.orange,
                                iconPath: 'assets/icons/firebase_icon.png',
                                gradientColors: [
                                  Colors.deepOrange,
                                  Colors.orangeAccent
                                ],
                              ),
                            ),
                            SizedBox(width: AppSizes.p16.left),
                            Expanded(
                              child: SkillLevelCard(
                                skillName: 'Kotlin',
                                skillLevel: 'Başlangıç',
                                percentage: 30,
                                color: Colors.purple,
                                iconPath: 'assets/icons/kotlin_icon.png',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Frameworks & Libraries başlığı
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
                          "Framework'ler ve Kütüphaneler",
                          style: const TextStyle(
                            fontSize: AppSizes.fontXL,
                            fontWeight: AppSizes.fontWeightSemiBold,
                            color: AppColors.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // FrameworkCard'lar: eşit genişlik
                  _animItem(
                    6,
                    Row(
                      children: List.generate(
                        frameworkCards.length * 2 - 1,
                        (i) {
                          if (i.isOdd) return SizedBox(width: itemGap);
                          return Expanded(child: frameworkCards[i ~/ 2]);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Tools & Platforms başlığı
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
                          'Araçlar ve Platformlar',
                          style: TextStyle(
                            fontSize: AppSizes.fontXL,
                            fontWeight: AppSizes.fontWeightSemiBold,
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // ToolCard'lar: eşit genişlik
                  _animItem(
                    8,
                    Row(
                      children: List.generate(
                        toolCards.length * 2 - 1,
                        (i) {
                          if (i.isOdd) return SizedBox(width: itemGap);
                          return Expanded(child: toolCards[i ~/ 2]);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
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
                                'Şu Anda Öğreniyorum',
                                style: TextStyle(
                                  fontSize: AppSizes.fontL,
                                  fontWeight: AppSizes.fontWeightSemiBold,
                                  color: const Color(0xFF111827),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RoundedButton(
                                firstText: "Kotlin",
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
      ),
    );
  }

  // frameworkCards ve toolCards listelerini sınıf içerisinde tanımlıyoruz:
  List<FrameworkCard> get frameworkCards => [
        FrameworkCard(
          title: "Flutter",
          level: "Temel Teknoloji",
          iconPath: "assets/icons/phone_icon.png",
          iconBackgroundColor: const Color(0xFF2563EB),
          badgeColor: const Color(0xFF6366F1),
        ),
        FrameworkCard(
          title: "React Native",
          level: "Orta Seviye",
          iconPath: "assets/icons/reactnative_icon.png",
          iconBackgroundColor: const Color(0xFF9333EA),
          badgeColor: const Color(0xFF8B5CF6),
        ),
        FrameworkCard(
          title: "Firebase",
          level: "Orta Seviye",
          iconPath: "assets/icons/firebase_icon.png",
          iconBackgroundColor: const Color(0xFFEA580C),
          badgeColor: const Color(0xFF6366F1),
        ),
        FrameworkCard(
          title: "Riverpod",
          level: "Orta Seviye",
          iconPath: "assets/icons/riverpod_icon.png",
          iconBackgroundColor: const Color(0xFF0D9488),
          badgeColor: const Color(0xFF8B5CF6),
        ),
      ];

  List<FrameworkCard> get toolCards => [
        FrameworkCard(
          title: "Git",
          iconPath: "assets/icons/git_icon.png",
          iconBackgroundColor: const Color(0xFF334155),
        ),
        FrameworkCard(
          title: "GitHub",
          iconPath: "assets/icons/github_icon.png",
          iconBackgroundColor: const Color(0xFF334155),
        ),
        FrameworkCard(
          title: "Figma",
          iconPath: "assets/icons/figma_icon.png",
          iconBackgroundColor: const Color(0xFF334155),
        ),
        FrameworkCard(
          title: "VS Code",
          iconPath: "assets/icons/riverpod_icon.png",
          iconBackgroundColor: const Color(0xFF334155),
        ),
        FrameworkCard(
          title: "Android Studio",
          iconPath: "assets/icons/kotlin_icon.png",
          iconBackgroundColor: const Color(0xFF334155),
        ),
      ];
}
