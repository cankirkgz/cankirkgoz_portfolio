import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/design/atoms/rounded_button.dart';
import 'package:my_portfolio/design/molecules/project_showcase_card.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _cardController;
  String _selectedFilter = "Tüm Projeler";
  bool _isFiltering = false;
  late List<ProjectShowcaseCard> _displayedProjects;

  @override
  void initState() {
    super.initState();
    _displayedProjects = _allProjects;

    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  Future<void> _filterProjects(String filter) async {
    if (_isFiltering || _selectedFilter == filter) return;

    setState(() {
      _isFiltering = true;
      _selectedFilter = filter;
    });

    await _cardController.reverse();

    List<ProjectShowcaseCard> newProjects;
    if (filter == "Tüm Projeler") {
      newProjects = _allProjects;
    } else if (filter == "Diğer") {
      newProjects = _allProjects
          .where((project) =>
              project.projectLanguage != "Flutter" &&
              project.projectLanguage != "Kotlin")
          .toList();
    } else {
      newProjects = _allProjects
          .where((project) => project.projectLanguage == filter)
          .toList();
    }

    setState(() {
      _displayedProjects = newProjects;
    });

    await _cardController.forward();
    setState(() {
      _isFiltering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackground,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSizes.breakpointDesktop),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.p24, vertical: AppSizes.p80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Başlık
                Text(
                  "Neler Geliştirdim",
                  style: TextStyle(
                    fontSize: AppSizes.fontXXXXL,
                    fontWeight: AppSizes.fontWeightBold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.p8),
                // Alt Başlık
                Text(
                  'Flutter, Firebase ve ileri düzey mobil teknolojilerle geliştirdiğim son projelerimden bazıları.',
                  style: TextStyle(
                    fontSize: AppSizes.fontL,
                    fontWeight: AppSizes.fontWeightRegular,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSizes.p48),
                // Filtre Butonları
                Wrap(
                  spacing: AppSizes.p30,
                  runSpacing: AppSizes.p16,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildFilterButton("Tüm Projeler"),
                    _buildFilterButton("Flutter"),
                    _buildFilterButton("Kotlin"),
                    _buildFilterButton("Diğer"),
                  ],
                ),
                const SizedBox(height: AppSizes.p48),
                // Proje Kartları
                _displayedProjects.isEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: AppSizes.p50),
                        child: Text(
                          "Çok yakında...",
                          style: TextStyle(
                            fontSize: AppSizes.fontL,
                            fontWeight: AppSizes.fontWeightMedium,
                            color: AppColors.textPrimary.withOpacity(0.6),
                          ),
                        ),
                      )
                    : Wrap(
                        key: ValueKey<String>(_selectedFilter),
                        spacing: AppSizes.p24,
                        runSpacing: AppSizes.p24,
                        alignment: WrapAlignment.center,
                        children: _displayedProjects.map((project) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.5, 0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: _cardController,
                              curve: Curves.easeOutQuart,
                            )),
                            child: FadeTransition(
                              opacity: _cardController,
                              child: project,
                            ),
                          );
                        }).toList(),
                      ),
                const SizedBox(height: AppSizes.p48),
                // GitHub Butonu
                RoundedButton(
                  firstText: "Tüm Projelerime Göz At",
                  icon: "assets/icons/github_icon.png",
                  onPressed: () {
                    html.window.open(
                        'https://github.com/cankirkgz?tab=repositories',
                        '_blank');
                  },
                  type: ButtonType.gradient,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    return RoundedButton(
      firstText: label,
      onPressed: () => _filterProjects(label),
      type: _selectedFilter == label ? ButtonType.gradient : ButtonType.outline,
      borderRadius: AppSizes.r999.bottomLeft.x,
    );
  }

  List<ProjectShowcaseCard> get _allProjects => [
        ProjectShowcaseCard(
          key: const ValueKey<String>("ternai"),
          projectLanguage: "Flutter",
          title: "Ternai",
          description:
              "Ternai, yurt dışı seyahat planlayan kullanıcılar için geliştirilen, maliyetleri karşılaştırarak tatil bütçesi oluşturmalarını sağlayan bir mobil uygulamadır.",
          badgeText: "Geliştiriliyor",
          badgeColor: AppColors.success,
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
            AppColors.primary,
            AppColors.skillOrange,
            AppColors.skillPurple,
            AppColors.primaryPurple,
            AppColors.textSecondary,
            AppColors.skillOrange,
            AppColors.primary,
          ],
          button1Text: 'Ziyaret',
          button1SecondText: 'Et',
          onButton1Pressed: () {},
          button2Text: 'Github',
          onButton2Pressed: () {
            html.window
                .open('https://github.com/cankirkgz/ternai-app', '_blank');
          },
          buttonHeight: AppSizes.buttonHeightXL,
        ),
        ProjectShowcaseCard(
          key: const ValueKey<String>("wedly"),
          projectLanguage: "Flutter",
          title: "Wedly",
          description:
              "Evlenmeye hazırlanan çiftler için oda bazlı eşya planlama ve listeleme uygulamasıdır. Offline desteklidir.",
          badgeText: "Yayında",
          badgeColor: AppColors.skillOrange,
          imagePath: "assets/images/wedly_mockup.png",
          techTags: ['Dart', 'Firebase', 'Hive', 'Riverpod', 'MVVM'],
          techTagColors: [
            AppColors.primaryblue,
            AppColors.error,
            AppColors.skillOrangeAccent,
            AppColors.primaryPurple,
            AppColors.textSecondary,
          ],
          button1Text: 'Yükle',
          onButton1Pressed: () {
            html.window.open(
                'https://play.google.com/store/apps/details?id=com.wedly.app&hl=tr',
                '_blank');
          },
          button2Text: 'GitHub',
          onButton2Pressed: () {
            html.window.open('https://github.com/cankirkgz/wedlist', '_blank');
          },
          buttonHeight: AppSizes.buttonHeightXL,
        ),
      ];
}
