import 'package:flutter/material.dart';
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
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Başlık
                Text(
                  "Neler Geliştirdim",
                  style: TextStyle(
                    fontSize: AppSizes.fontXXXXL,
                    fontWeight: AppSizes.fontWeightBold,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 8),
                // Alt Başlık
                Text(
                  'Flutter, Firebase ve ileri düzey mobil teknolojilerle geliştirdiğim son projelerimden bazıları.',
                  style: TextStyle(
                    fontSize: AppSizes.fontL,
                    fontWeight: AppSizes.fontWeightRegular,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 48),
                // Filtre Butonları
                Wrap(
                  spacing: 30,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildFilterButton("Tüm Projeler"),
                    _buildFilterButton("Flutter"),
                    _buildFilterButton("Kotlin"),
                    _buildFilterButton("Diğer"),
                  ],
                ),
                const SizedBox(height: 48),
                // Proje Kartları
                _displayedProjects.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
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
                        spacing: 24,
                        runSpacing: 24,
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
                const SizedBox(height: 48),
                // GitHub Butonu
                RoundedButton(
                  firstText: "Tüm Projelerime Göz At",
                  icon: "assets/icons/github_icon.png",
                  onPressed: () {},
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
      borderRadius: 9999,
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
          button2Text: 'Github',
          onButton2Pressed: () {},
          buttonHeight: AppSizes.buttonHeightXL,
        ),
        ProjectShowcaseCard(
          key: const ValueKey<String>("wedly"),
          projectLanguage: "Flutter",
          title: "Wedly",
          description:
              "Evlenmeye hazırlanan çiftler için oda bazlı eşya planlama ve listeleme uygulamasıdır. Offline desteklidir.",
          badgeText: "Yayında",
          badgeColor: Colors.orange,
          imagePath: "assets/images/wedly_mockup.png",
          techTags: ['Dart', 'Firebase', 'Hive', 'Riverpod', 'MVVM'],
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
      ];
}
