import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/design/atoms/rounded_button.dart';
import 'package:my_portfolio/design/molecules/project_showcase_card.dart';
import 'package:my_portfolio/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _cardController;
  late String _selectedFilterKey;
  List<ProjectShowcaseCard> _displayedProjects = [];
  bool _isFiltering = false;

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _selectedFilterKey = "allProjects";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 1) Her seferinde güncel lokalizasyonu al
    final appLocalizations = AppLocalizations.of(context)!;
    final allProjects = _buildAllProjects(appLocalizations);

    // 2) Hangi filtre aktifse ona göre _displayedProjects'i oluştur
    if (_selectedFilterKey == 'allProjects') {
      _displayedProjects = allProjects;
    } else if (_selectedFilterKey == 'flutter') {
      _displayedProjects = allProjects
          .where((p) => p.projectLanguage == appLocalizations.flutter)
          .toList();
    } else if (_selectedFilterKey == 'kotlin') {
      _displayedProjects = allProjects
          .where((p) => p.projectLanguage == appLocalizations.kotlin)
          .toList();
    } else if (_selectedFilterKey == 'other') {
      _displayedProjects = allProjects
          .where((p) =>
              p.projectLanguage != appLocalizations.flutter &&
              p.projectLanguage != appLocalizations.kotlin)
          .toList();
    } else {
      _displayedProjects = allProjects;
    }

    // 3) (İstersen) kart animasyonunu baştan oynatmak için:
    _cardController.forward(from: 0);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  Future<void> _filterProjects(String filterKey) async {
    if (_isFiltering || _selectedFilterKey == filterKey) return;

    setState(() {
      _isFiltering = true;
      _selectedFilterKey = filterKey;
    });

    await _cardController.reverse();

    final appLocalizations = AppLocalizations.of(context)!;
    final allProjects = _buildAllProjects(appLocalizations);

    List<ProjectShowcaseCard> newProjects;

    if (filterKey == "allProjects") {
      newProjects = allProjects;
    } else if (filterKey == "other") {
      newProjects = allProjects
          .where((project) =>
              project.projectLanguage != appLocalizations.flutter &&
              project.projectLanguage != appLocalizations.kotlin)
          .toList();
    } else if (filterKey == "flutter") {
      newProjects = allProjects
          .where(
              (project) => project.projectLanguage == appLocalizations.flutter)
          .toList();
    } else if (filterKey == "kotlin") {
      newProjects = allProjects
          .where(
              (project) => project.projectLanguage == appLocalizations.kotlin)
          .toList();
    } else {
      newProjects = allProjects;
    }

    setState(() {
      _displayedProjects = newProjects;
    });

    await _cardController.forward();
    setState(() {
      _isFiltering = false;
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground(context),
      ),
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
                  appLocalizations.projects,
                  style: TextStyle(
                    fontSize: AppSizes.fontXXXXL,
                    fontWeight: AppSizes.fontWeightBold,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                const SizedBox(height: AppSizes.p8),
                // Alt Başlık
                Text(
                  appLocalizations.projectsSubtitle,
                  style: TextStyle(
                    fontSize: AppSizes.fontL,
                    fontWeight: AppSizes.fontWeightRegular,
                    color: AppColors.textSecondary(context),
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
                        appLocalizations.allProjects, "allProjects"),
                    _buildFilterButton(appLocalizations.flutter, "flutter"),
                    _buildFilterButton(appLocalizations.kotlin, "kotlin"),
                    _buildFilterButton(appLocalizations.other, "other"),
                  ],
                ),
                const SizedBox(height: AppSizes.p48),
                // Proje Kartları
                _displayedProjects.isEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: AppSizes.p50),
                        child: Text(
                          appLocalizations.comingSoon,
                          style: TextStyle(
                            fontSize: AppSizes.fontL,
                            fontWeight: AppSizes.fontWeightMedium,
                            color:
                                AppColors.textPrimary(context).withOpacity(0.6),
                          ),
                        ),
                      )
                    : Wrap(
                        key: ValueKey<String>(_selectedFilterKey),
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
                  firstText: appLocalizations.viewAllProjects,
                  icon: "assets/icons/github_icon.png",
                  onPressed: () {
                    _launchURL('https://github.com/cankirkgz?tab=repositories');
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

  Widget _buildFilterButton(String label, String filterKey) {
    return RoundedButton(
      firstText: label,
      onPressed: () => _filterProjects(filterKey),
      type: _selectedFilterKey == filterKey
          ? ButtonType.gradient
          : ButtonType.outline,
      borderRadius: AppSizes.r999.bottomLeft.x,
    );
  }

  List<ProjectShowcaseCard> _buildAllProjects(
      AppLocalizations appLocalizations) {
    return [
      ProjectShowcaseCard(
        key: const ValueKey<String>("ternai"),
        projectLanguage: appLocalizations.flutter,
        title: appLocalizations.ternai,
        description: appLocalizations.ternaiProjectDescription,
        badgeText: appLocalizations.inDevelopment,
        badgeColor: AppColors.success,
        imagePath: "assets/images/ternai_mockup.png",
        techTags: [
          appLocalizations.flutter,
          appLocalizations.firebase,
          appLocalizations.hive,
          appLocalizations.riverpod,
          appLocalizations.mvvm,
          appLocalizations.bootcampFinalist,
          appLocalizations.empowerMeFinalist
        ],
        techTagColors: [
          AppColors.primary,
          AppColors.skillOrange,
          AppColors.skillPurple,
          AppColors.primaryPurple,
          AppColors.textSecondary(context),
          AppColors.skillOrange,
          AppColors.primary,
        ],
        button1Text: appLocalizations.visit,
        button1SecondText: appLocalizations.localeName == 'tr' ? 'Et' : null,
        onButton1Pressed: () {},
        button2Text: appLocalizations.github,
        onButton2Pressed: () {
          _launchURL('https://github.com/cankirkgz/ternai-app');
        },
        buttonHeight: AppSizes.buttonHeightXL,
      ),
      ProjectShowcaseCard(
        key: const ValueKey<String>("wedly"),
        projectLanguage: appLocalizations.flutter,
        title: appLocalizations.wedly,
        description: appLocalizations.wedlyProjectDescription,
        badgeText: appLocalizations.published,
        badgeColor: AppColors.skillOrange,
        imagePath: "assets/images/wedly_mockup.png",
        techTags: [
          appLocalizations.dart,
          appLocalizations.firebase,
          appLocalizations.hive,
          appLocalizations.riverpod,
          appLocalizations.mvvm
        ],
        techTagColors: [
          AppColors.primaryblue,
          AppColors.error,
          AppColors.skillOrangeAccent,
          AppColors.primaryPurple,
          AppColors.textSecondary(context),
        ],
        button1Text: appLocalizations.download,
        onButton1Pressed: () {
          _launchURL(
              'https://play.google.com/store/apps/details?id=com.wedly.app&hl=tr');
        },
        button2Text: appLocalizations.github,
        onButton2Pressed: () {
          _launchURL('https://github.com/cankirkgz/wedlist');
        },
        buttonHeight: AppSizes.buttonHeightXL,
      ),
    ];
  }
}
