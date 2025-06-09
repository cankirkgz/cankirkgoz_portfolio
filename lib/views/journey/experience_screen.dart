import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

/// ExperienceScreen shows a timeline of work/education entries with entrance animations.
class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Animation<double>> _fadeIns = [];
  final List<Animation<Offset>> _slides = [];
  final int _entryCount = 5; // number of timeline entries

  @override
  void initState() {
    super.initState();
    // Initialize controller for 1200ms total animation duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward(); // start animations immediately

    // Create staggered animations for each entry
    for (int i = 0; i < _entryCount; i++) {
      final start = i / _entryCount;
      final end = (i + 1) / _entryCount;
      // Fade in from 0 to 1
      _fadeIns.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeIn),
          ),
        ),
      );
      // Slide up slightly into place
      _slides.add(
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // release animation controller
    super.dispose();
  }

  /// Builds an animated version of each timeline entry.
  Widget _buildAnimatedEntry(int index, Widget entry) {
    return FadeTransition(
      opacity: _fadeIns[index],
      child: SlideTransition(
        position: _slides[index],
        child: entry,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    // Define experience entries data
    final entries = [
      _ExperienceEntry(
        icon: FontAwesomeIcons.code,
        iconBg: AppColors.primary,
        title: appLocalizations.ternaiLeaderTitle,
        subtitle: 'Ternai',
        date: appLocalizations.ternaiLeaderDate,
        location: appLocalizations.ankaraTurkeyLocation,
        statusBadge: appLocalizations.activeStatus,
        bulletColor: AppColors.primary,
        points: [
          appLocalizations.ternaiPoint1,
          appLocalizations.ternaiPoint2,
          appLocalizations.ternaiPoint3,
          appLocalizations.ternaiPoint4,
          appLocalizations.ternaiPoint5,
        ],
        tags: [
          appLocalizations.flutter,
          appLocalizations.firebase,
          appLocalizations.riverpod,
          appLocalizations.hive,
          appLocalizations.mvvm,
          appLocalizations.autoRouteTag,
          appLocalizations.teamLeadershipTag,
          appLocalizations.uxUiTag
        ],
      ),
      _ExperienceEntry(
        icon: FontAwesomeIcons.mobileScreen,
        iconBg: AppColors.primary,
        title: appLocalizations.moneypayTitle,
        subtitle: 'Moneypay',
        date: appLocalizations.moneypayDate,
        location: appLocalizations.remoteAnkaraLocation,
        statusBadge: appLocalizations.remoteStatus,
        bulletColor: AppColors.primary,
        points: [
          appLocalizations.moneypayPoint1,
          appLocalizations.moneypayPoint2,
          appLocalizations.moneypayPoint3,
          appLocalizations.moneypayPoint4,
        ],
        tags: [
          appLocalizations.flutter,
          appLocalizations.firebase,
          appLocalizations.mvcTag,
          appLocalizations.autoRouteTag,
          appLocalizations.agileTag,
          appLocalizations.scrumTag,
          appLocalizations.teamworkTag,
        ],
      ),
      _ExperienceEntry(
        icon: FontAwesomeIcons.computer,
        iconBg: AppColors.primaryPurple,
        title: appLocalizations.vitraTitle,
        subtitle: 'VitrA Karo (Eczacıbaşı)',
        date: appLocalizations.vitraDate,
        location: appLocalizations.remoteStatus,
        statusBadge: appLocalizations.remoteStatus,
        bulletColor: AppColors.primaryPurple,
        points: [
          appLocalizations.vitraPoint1,
          appLocalizations.vitraPoint2,
          appLocalizations.vitraPoint3,
        ],
        tags: [
          appLocalizations.sapTag,
          appLocalizations.projectTrackingTag,
          appLocalizations.corporateExperienceTag,
          appLocalizations.teamCommunicationTag
        ],
      ),
      _ExperienceEntry(
        icon: FontAwesomeIcons.building,
        iconBg: AppColors.primary,
        title: appLocalizations.akbankTitle,
        subtitle: 'Akbank',
        date: appLocalizations.akbankDate,
        location: appLocalizations.remoteStatus,
        statusBadge: appLocalizations.remoteStatus,
        bulletColor: AppColors.primary,
        points: [
          appLocalizations.akbankPoint1,
          appLocalizations.akbankPoint2,
          appLocalizations.akbankPoint3,
        ],
        tags: [
          appLocalizations.agileTag,
          appLocalizations.scrumTag,
          appLocalizations.teamworkTag,
          appLocalizations.corporateExperienceTag
        ],
      ),
      _ExperienceEntry(
        icon: FontAwesomeIcons.codeBranch,
        iconBg: AppColors.certGreen,
        title: appLocalizations.fazlaTitle,
        subtitle: 'Fazla',
        date: appLocalizations.fazlaDate,
        location: appLocalizations.remoteStatus,
        statusBadge: appLocalizations.remoteStatus,
        bulletColor: AppColors.certGreen,
        points: [
          appLocalizations.fazlaPoint1,
          appLocalizations.fazlaPoint2,
          appLocalizations.fazlaPoint3,
        ],
        tags: [
          appLocalizations.reactNative,
          appLocalizations.typeScriptTag,
          appLocalizations.restApiTag,
          appLocalizations.figma,
          appLocalizations.git
        ],
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBackground, // Tek renk arka plan
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p24, vertical: AppSizes.p80),
        child: Column(
          children: [
            // Header section
            _buildHeader(),
            const SizedBox(height: AppSizes.p32),
            // Timeline with animations
            _buildTimeline(entries),
            const SizedBox(height: AppSizes.p32),
            // Achievement banner at bottom
            _buildAchievementBanner(),
          ],
        ),
      ),
    );
  }

  /// Header with title and subtitle
  Widget _buildHeader() {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        Text(
          appLocalizations.journey,
          style: const TextStyle(
            fontSize: AppSizes.fontXXXXL,
            fontWeight: AppSizes.fontWeightBold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.p8),
        Text(
          appLocalizations.journeySubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: AppSizes.fontL,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  /// Builds the vertical timeline with animated entries
  Widget _buildTimeline(List<_ExperienceEntry> entries) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        if (isMobile) {
          // Single column, full width entries
          return Column(
            children: List.generate(entries.length, (i) {
              return _buildAnimatedEntry(
                i,
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.p32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // bullet dot
                      Container(
                        width: AppSizes.p12,
                        height: AppSizes.p12,
                        decoration: BoxDecoration(
                          color: entries[i].bulletColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSizes.p16),
                      // full‐width entry
                      Expanded(child: entries[i]),
                    ],
                  ),
                ),
              );
            }),
          );
        } else {
          // Your existing two‐sided Stack + alternating left/right layout:
          final centerX = constraints.maxWidth / 2;
          return Stack(
            children: [
              // center line…
              Positioned(
                left: centerX - AppSizes.p1,
                top: 0,
                bottom: 0,
                child: Container(width: AppSizes.p2, color: AppColors.primary),
              ),
              Column(
                children: List.generate(entries.length, (i) {
                  return _buildAnimatedEntry(
                    i,
                    Container(
                      margin: const EdgeInsets.only(bottom: AppSizes.p32),
                      child: Row(
                        children: [
                          Expanded(
                            child: i.isEven
                                ? _buildSide(entries[i], centerX,
                                    alignRight: true)
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(width: AppSizes.p24), // spacer for dot
                          Expanded(
                            child: i.isOdd
                                ? _buildSide(entries[i], centerX,
                                    alignRight: false)
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        }
      },
    );
  }

  /// Helper to align entry box on either side
  Widget _buildSide(_ExperienceEntry entry, double centerX,
      {required bool alignRight}) {
    return Align(
      alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: centerX - AppSizes.p32),
        child: entry, // actual entry widget
      ),
    );
  }

  /// Banner showing achievements with icons and values
  Widget _buildAchievementBanner() {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(AppSizes.p24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primaryPurple]),
        borderRadius: AppSizes.r24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _AchievementItem(
              icon: FontAwesomeIcons.trophy,
              value: '1+',
              label: appLocalizations.yearsExperience),
          _AchievementItem(
              icon: FontAwesomeIcons.projectDiagram,
              value: '3+',
              label: appLocalizations.developedProjects),
          _AchievementItem(
              icon: FontAwesomeIcons.codeBranch,
              value: '300+',
              label: appLocalizations.commits),
        ],
      ),
    );
  }
}

/// Defines each timeline entry UI block
class _ExperienceEntry extends StatefulWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String date;
  final String location;
  final String statusBadge;
  final Color bulletColor;
  final List<String> points;
  final List<String> tags;

  const _ExperienceEntry({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.location,
    required this.statusBadge,
    required this.bulletColor,
    required this.points,
    required this.tags,
  });

  @override
  State<_ExperienceEntry> createState() => _ExperienceEntryState();
}

class _ExperienceEntryState extends State<_ExperienceEntry> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform:
            Matrix4.translationValues(0, _isHovered ? -AppSizes.p8 : 0, 0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: AppSizes.r16,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.1),
                blurRadius: AppSizes.p20,
                offset: const Offset(0, AppSizes.p8),
                spreadRadius: AppSizes.p2,
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppSizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. İkon kısmı
                  Container(
                    width: AppSizes.p48,
                    height: AppSizes.p48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [widget.iconBg, widget.iconBg.withOpacity(0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: AppSizes.r12,
                    ),
                    child: Center(
                      child: FaIcon(
                        widget.icon,
                        color: AppColors.scaffoldBackground,
                        size: AppSizes.iconM,
                      ),
                    ),
                  ),

                  const SizedBox(width: AppSizes.p12),

                  // 2. Başlık ve alt başlık
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: AppSizes.fontXL,
                            fontWeight: AppSizes.fontWeightSemiBold,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        const SizedBox(height: AppSizes.p4),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            color: widget.iconBg,
                            fontWeight: AppSizes.fontWeightMedium,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: AppSizes.p12),

                  // 3. Status badge (sağ üstte)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.p12,
                      vertical: AppSizes.p4,
                    ),
                    decoration: BoxDecoration(
                      color: widget.bulletColor.withOpacity(0.2),
                      borderRadius: AppSizes.r8,
                    ),
                    child: Text(
                      widget.statusBadge,
                      style: TextStyle(
                        color: widget.bulletColor,
                        fontSize: AppSizes.fontXs,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.p8),
              Text(
                widget.date,
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSizes.p4),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.locationDot,
                    size: AppSizes.fontS,
                    color: AppColors.icon,
                  ),
                  const SizedBox(width: AppSizes.p6),
                  Expanded(
                    child: Text(
                      widget.location,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.p12),
              ...widget.points.map((p) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.p2),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.circleCheck,
                          size: AppSizes.fontS,
                          color: widget.bulletColor,
                        ),
                        const SizedBox(width: AppSizes.p6),
                        Expanded(
                          child: Text(
                            p,
                            style:
                                const TextStyle(color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: AppSizes.p12),
              Wrap(
                spacing: AppSizes.p8,
                runSpacing: AppSizes.p6,
                children: widget.tags
                    .map((t) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.p8,
                            vertical: AppSizes.p4,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: AppSizes.r6,
                          ),
                          child: Text(
                            t,
                            style: const TextStyle(fontSize: AppSizes.fontXs),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Achievement item showing icon with value and label
class _AchievementItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _AchievementItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          icon,
          color: AppColors.scaffoldBackground,
          size: AppSizes.iconXXL,
        ),
        const SizedBox(width: AppSizes.p8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: AppColors.scaffoldBackground,
                fontSize: AppSizes.fontXXL,
                fontWeight: AppSizes.fontWeightBold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: AppColors.scaffoldBackground.withOpacity(0.9),
                fontSize: AppSizes.fontS,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
