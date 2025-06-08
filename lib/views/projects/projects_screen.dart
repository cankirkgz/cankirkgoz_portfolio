import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  late String _selectedFilter;
  bool _isFiltering = false;
  late List<ProjectShowcaseCard> _displayedProjects;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _selectedFilter = AppLocalizations.of(context)!.allProjects;
      _displayedProjects = _allProjects;
      _initialized = true;
    }
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
    if (filter == AppLocalizations.of(context)!.allProjects) {
      newProjects = _allProjects;
    } else if (filter == AppLocalizations.of(context)!.other) {
      newProjects = _allProjects
          .where((project) =>
              project.projectLanguage !=
                  AppLocalizations.of(context)!.flutter &&
              project.projectLanguage != AppLocalizations.of(context)!.kotlin)
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
                  AppLocalizations.of(context)!.projects,
                  style: const TextStyle(
                    fontSize: AppSizes.fontXXXXL,
                    fontWeight: AppSizes.fontWeightBold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.p8),
                // Alt Başlık
                Text(
                  AppLocalizations.of(context)!.projectsSubtitle,
                  style: const TextStyle(
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
                    _buildFilterButton(
                        AppLocalizations.of(context)!.allProjects),
                    _buildFilterButton(AppLocalizations.of(context)!.flutter),
                    _buildFilterButton(AppLocalizations.of(context)!.kotlin),
                    _buildFilterButton(AppLocalizations.of(context)!.other),
                  ],
                ),
                const SizedBox(height: AppSizes.p48),
                // Proje Kartları
                _displayedProjects.isEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: AppSizes.p50),
                        child: Text(
                          AppLocalizations.of(context)!.comingSoon,
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
                  firstText: AppLocalizations.of(context)!.viewAllProjects,
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
          projectLanguage: AppLocalizations.of(context)!.flutter,
          title: AppLocalizations.of(context)!.ternai,
          description: AppLocalizations.of(context)!.ternaiDescription,
          badgeText: AppLocalizations.of(context)!.inDevelopment,
          badgeColor: AppColors.success,
          imagePath: "assets/images/ternai_mockup.png",
          techTags: [
            AppLocalizations.of(context)!.flutter,
            AppLocalizations.of(context)!.firebase,
            AppLocalizations.of(context)!.hive,
            AppLocalizations.of(context)!.riverpod,
            AppLocalizations.of(context)!.mvvm,
            AppLocalizations.of(context)!.bootcampFinalist,
            AppLocalizations.of(context)!.empowerMeFinalist
          ],
          techTagColors: const [
            AppColors.primary,
            AppColors.skillOrange,
            AppColors.skillPurple,
            AppColors.primaryPurple,
            AppColors.textSecondary,
            AppColors.skillOrange,
            AppColors.primary,
          ],
          button1Text: AppLocalizations.of(context)!.visit,
          button1SecondText: 'Et',
          onButton1Pressed: () {},
          button2Text: AppLocalizations.of(context)!.github,
          onButton2Pressed: () {
            html.window
                .open('https://github.com/cankirkgz/ternai-app', '_blank');
          },
          buttonHeight: AppSizes.buttonHeightXL,
        ),
        ProjectShowcaseCard(
          key: const ValueKey<String>("wedly"),
          projectLanguage: AppLocalizations.of(context)!.flutter,
          title: AppLocalizations.of(context)!.wedly,
          description: AppLocalizations.of(context)!.wedlyDescription,
          badgeText: AppLocalizations.of(context)!.published,
          badgeColor: AppColors.skillOrange,
          imagePath: "assets/images/wedly_mockup.png",
          techTags: [
            AppLocalizations.of(context)!.dart,
            AppLocalizations.of(context)!.firebase,
            AppLocalizations.of(context)!.hive,
            AppLocalizations.of(context)!.riverpod,
            AppLocalizations.of(context)!.mvvm
          ],
          techTagColors: const [
            AppColors.primaryblue,
            AppColors.error,
            AppColors.skillOrangeAccent,
            AppColors.primaryPurple,
            AppColors.textSecondary,
          ],
          button1Text: AppLocalizations.of(context)!.download,
          onButton1Pressed: () {
            html.window.open(
                'https://play.google.com/store/apps/details?id=com.wedly.app&hl=tr',
                '_blank');
          },
          button2Text: AppLocalizations.of(context)!.github,
          onButton2Pressed: () {
            html.window.open('https://github.com/cankirkgz/wedlist', '_blank');
          },
          buttonHeight: AppSizes.buttonHeightXL,
        ),
      ];
}
