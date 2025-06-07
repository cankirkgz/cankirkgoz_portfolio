import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/design/atoms/rounded_button.dart';
import 'package:my_portfolio/design/molecules/project_showcase_card.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<Offset>> _slideAnims = [];
  final List<Animation<double>> _fadeAnims = [];
  final int _itemCount = 7; // total animated items

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  _animItem(
                    0,
                    Text(
                      "Neler Geliştirdim",
                      style: TextStyle(
                        fontSize: AppSizes.fontXXXXL,
                        fontWeight: AppSizes.fontWeightBold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  _animItem(
                    1,
                    Text(
                      'Flutter, Firebase ve ileri düzey mobil teknolojilerle geliştirdiğim son projelerimden bazıları.',
                      style: TextStyle(
                        fontSize: AppSizes.fontL,
                        fontWeight: AppSizes.fontWeightRegular,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Filter buttons
                  _animItem(
                    2,
                    Wrap(
                      spacing: 30,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        RoundedButton(
                          firstText: "Tüm Projeler",
                          onPressed: () {},
                          type: ButtonType.gradient,
                          borderRadius: 9999,
                        ),
                        RoundedButton(
                          firstText: "Flutter",
                          onPressed: () {},
                          type: ButtonType.outline,
                          borderRadius: 9999,
                        ),
                        RoundedButton(
                          firstText: "Kotlin",
                          onPressed: () {},
                          type: ButtonType.outline,
                          borderRadius: 9999,
                        ),
                        RoundedButton(
                          firstText: "Diğer",
                          onPressed: () {},
                          type: ButtonType.outline,
                          borderRadius: 9999,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Section Header
                  _animItem(
                    3,
                    Text(
                      'Öne Çıkan Projeler',
                      style: TextStyle(
                        fontSize: AppSizes.fontXL,
                        fontWeight: AppSizes.fontWeightSemiBold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Animated cards in a Wrap for side-by-side layout
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      _animItem(
                        4,
                        ProjectShowcaseCard(
                          title: "Ternai",
                          description:
                              "Ternai, yurt dışı seyahat planlayan kullanıcılar için geliştirilen, farklı ülkelerdeki restoran, ulaşım, konaklama ve günlük yaşam maliyetlerini karşılaştırarak bütçe oluşturmayı kolaylaştıran bir mobil uygulamadır. Yapay zeka desteğiyle kişiye özel tatil planları sunar, offline çalışma desteğiyle her yerde kullanılabilir ve kullanıcılar arası deneyim paylaşımıyla sosyal bir seyahat ağı oluşturur.",
                          badgeText: "Geliştiriliyor",
                          badgeColor: Colors.green,
                          imagePath: "assets/images/ternai_mockup.png",
                          techTags: [
                            'Flutter',
                            'Firebase',
                            'Hive',
                            'Riverpod',
                            'MVVM',
                            'Bootcamp Finalisti',
                            'EmpowerMe Finalisti'
                          ],
                          techTagColors: [
                            Colors.blue,
                            Colors.orange,
                            Colors.purple,
                            Colors.deepPurple,
                            Colors.teal,
                            Colors.orange,
                            Colors.blue,
                          ],
                          button1Text: 'Ziyaret',
                          button1SecondText: 'Et',
                          onButton1Pressed: () {},
                          button2Text: 'Gthub',
                          onButton2Pressed: () {},
                          buttonHeight: AppSizes.buttonHeightXL,
                        ),
                      ),
                      _animItem(
                        5,
                        ProjectShowcaseCard(
                          title: "Wedly",
                          description:
                              "Evlenmeye hazırlanan çiftler için geliştirilmiş oda bazlı eşya planlama uygulamasıdır. Kategorilere ayrılmış listeler, offline destek ve kullanıcı dostu tasarımıyla düğün hazırlıklarını kolaylaştırır.",
                          badgeText: "Yayında",
                          badgeColor: Colors.orange,
                          imagePath: "assets/images/wedly_mockup.png",
                          techTags: [
                            'Dart',
                            'Firebase',
                            'Hive',
                            'Riverpod',
                            'MVVM'
                          ],
                          techTagColors: [
                            Colors.cyan,
                            Colors.red,
                            Colors.amber,
                            Colors.deepPurple,
                            Colors.teal,
                          ],
                          button1Text: 'Yükle',
                          onButton1Pressed: () {},
                          button2Text: 'GitHub',
                          onButton2Pressed: () {},
                          buttonHeight: AppSizes.buttonHeightXL,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // View All button
                  _animItem(
                    6,
                    Center(
                      child: RoundedButton(
                        firstText: "Tüm Projelerime Göz At",
                        icon: "assets/icons/github_icon.png",
                        onPressed: () {},
                        type: ButtonType.gradient,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
