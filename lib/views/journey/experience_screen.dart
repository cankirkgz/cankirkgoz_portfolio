import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    // Define experience entries data
    final entries = [
      _ExperienceEntry(
        icon: FontAwesomeIcons.code,
        iconBg: AppColors.primary,
        title: 'Takım Lideri - Flutter Developer',
        subtitle: 'Ternai',
        date: 'Temmuz 2024 – Devam ediyor',
        location: ' Ankara, Türkiye',
        statusBadge: 'Aktif',
        bulletColor: AppColors.primary,
        points: [
          '5 kişilik bir ekibi yöneterek yapay zeka destekli tatil bütçeleme uygulaması geliştirdim.',
          'Flutter ile MVVM mimarisi, AutoRoute, Firebase, Hive ve Provider kullanarak gelişmiş bir mobil yapı kurdum.',
          'API tüketimi, offline destek, favori sistemi ve çoklu filtreleme mekanizmaları gibi modülleri geliştirdim.',
          "EmpowerMe Bootcamp'te 50+ takım arasında finalist olarak seçildik ve hızlandırma programına kabul edildik.",
          'Kullanıcı araştırmaları, sunumlar ve demo videolarla yatırımcı görüşmelerine katkı sağladım.',
        ],
        tags: [
          'Flutter',
          'Firebase',
          'Riverpod',
          'Hive',
          'MVVM',
          'AutoRoute',
          'Team Leadership',
          'UX/UI'
        ],
      ),
      _ExperienceEntry(
        icon: FontAwesomeIcons.mobileScreen,
        iconBg: AppColors.primary,
        title: 'Flutter Developer',
        subtitle: 'Moneypay',
        date: 'Ağustos 2024 – Aralık 2024',
        location: 'Uzaktan / Ankara, Türkiye',
        statusBadge: 'Uzaktan',
        bulletColor: AppColors.primary,
        points: [
          'Flutter ile sürdürülebilir ve ölçeklenebilir mobil uygulama geliştirme süreçlerinde aktif rol aldım.',
          'Firebase Authentication, Firestore, Hive ve Provider gibi teknolojilerle kullanıcı yönetimi ve veri işleme işlemlerini yönettim.',
          'MVVM mimarisi, AutoRoute ve Lottie animasyonları ile profesyonel uygulama deneyimi sağladım.',
          'Kod inceleme, test ve hata ayıklama süreçlerine katkı sağladım.',
        ],
        tags: [
          'Flutter',
          'Firebase',
          'MVC',
          'AutoRoute',
          'Agile',
          'Scrum',
          'Takım Çalışması',
        ],
      ),
      _ExperienceEntry(
        icon: FontAwesomeIcons.computer,
        iconBg: AppColors.primaryPurple,
        title: 'BT Takım Asistani',
        subtitle: 'VitrA Karo (Eczacıbaşı)',
        date: 'Şubat 2024 – Mayıs 2024',
        location: 'Uzaktan',
        statusBadge: 'Uzaktan',
        bulletColor: AppColors.primaryPurple,
        points: [
          'BT süreçlerinin işleyişini gözlemleyerek kurumsal teknoloji altyapısı hakkında bilgi edindim.',
          'Toplantı notları, görev takibi ve iç iletişim süreçlerinde aktif rol aldım.',
          'Proje yönetim süreçlerinde kullanılan araçlar ve sistemler konusunda destek sağladım.',
        ],
        tags: ['SAP', 'Proje Takibi', 'Kurumsal Deneyim', 'Takım İletişimi'],
      ),
      _ExperienceEntry(
        icon: FontAwesomeIcons.building,
        iconBg: AppColors.primary,
        title: 'BT. Takım Asistanı',
        subtitle: 'Akbank',
        date: 'Kasım 2023 – Şubat 2024',
        location: 'Uzaktan',
        statusBadge: 'Uzaktan',
        bulletColor: AppColors.primary,
        points: [
          'BT departmanında yürütülen yazılım ve proje geliştirme süreçlerini gözlemledim.',
          'Scrum toplantılarına katılarak kurumsal çevik metodolojileri deneyimledim.',
          'Takım içi dokümantasyon, raporlama ve görev takibi gibi destek süreçlerinde sorumluluk aldım.',
        ],
        tags: ['Agile', 'Scrum', 'Takım Çalışması', 'Kurumsal Deneyim'],
      ),
      _ExperienceEntry(
        icon: FontAwesomeIcons.codeBranch,
        iconBg: AppColors.certGreen,
        title: 'React Native Intern',
        subtitle: 'Fazla',
        date: 'Ağustos 2023 – Kasım 2023',
        location: 'Uzaktan',
        statusBadge: 'Uzaktan',
        bulletColor: AppColors.certGreen,
        points: [
          'Stok takip uygulaması geliştirdim ve test süreçlerine katkı sağladım.',
          'React Native ile mobil arayüzler tasarlayıp veri yönetimini sağladım.',
          'Ekip içi kod incelemelerine katılarak yazılım geliştirme süreçlerini öğrendim.',
        ],
        tags: ['React Native', 'TypeScript', 'REST API', 'Figma', 'Git'],
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
    return Column(
      children: [
        Text(
          'Yolculuğum',
          style: TextStyle(
            fontSize: AppSizes.fontXXXXL,
            fontWeight: AppSizes.fontWeightBold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.p8),
        Text(
          "Çalıştığım yerler ve bu yolda öğrendiklerim",
          textAlign: TextAlign.center,
          style: TextStyle(
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
        final centerX = constraints.maxWidth / 2; // center line x-coord
        return Stack(
          children: [
            // Central vertical line
            Positioned(
              left: centerX - AppSizes.p1,
              top: 0,
              bottom: 0,
              child: Container(width: AppSizes.p2, color: AppColors.primary),
            ),
            Column(
              children: List.generate(entries.length, (i) {
                // Build and animate each entry row
                return _buildAnimatedEntry(
                  i,
                  Container(
                    margin: EdgeInsets.only(bottom: AppSizes.p32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side or placeholder
                        Expanded(
                          child: i.isEven
                              ? _buildSide(entries[i], centerX,
                                  alignRight: true)
                              : const SizedBox.shrink(),
                        ),
                        // Bullet dot at center
                        SizedBox(
                          width: AppSizes.p24,
                          child: Column(
                            children: [
                              Container(
                                width: AppSizes.p12,
                                height: AppSizes.p12,
                                decoration: BoxDecoration(
                                  color: entries[i].bulletColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.scaffoldBackground,
                                      width: AppSizes.p2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Right side or placeholder
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
    return Container(
      padding: EdgeInsets.all(AppSizes.p24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryPurple]),
        borderRadius: AppSizes.r24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _AchievementItem(
              icon: FontAwesomeIcons.trophy,
              value: '1+',
              label: 'Yıllık Deneyim'),
          _AchievementItem(
              icon: FontAwesomeIcons.projectDiagram,
              value: '3+',
              label: 'Geliştirilen Proje'),
          _AchievementItem(
              icon: FontAwesomeIcons.codeBranch,
              value: '300+',
              label: 'Commit'),
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
          padding: EdgeInsets.all(AppSizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: AppSizes.p48,
                        height: AppSizes.p48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              widget.iconBg,
                              widget.iconBg.withOpacity(0.7)
                            ],
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
                      SizedBox(width: AppSizes.p12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: AppSizes.fontXL,
                              fontWeight: AppSizes.fontWeightSemiBold,
                            ),
                          ),
                          Text(
                            widget.subtitle,
                            style: TextStyle(
                              color: widget.iconBg,
                              fontWeight: AppSizes.fontWeightMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
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
              SizedBox(height: AppSizes.p8),
              Text(
                widget.date,
                style: TextStyle(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSizes.p4),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.locationDot,
                    size: AppSizes.fontS,
                    color: AppColors.icon,
                  ),
                  SizedBox(width: AppSizes.p6),
                  Expanded(
                    child: Text(
                      widget.location,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.p12),
              ...widget.points.map((p) => Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSizes.p2),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.circleCheck,
                          size: AppSizes.fontS,
                          color: widget.bulletColor,
                        ),
                        SizedBox(width: AppSizes.p6),
                        Expanded(
                          child: Text(
                            p,
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: AppSizes.p12),
              Wrap(
                spacing: AppSizes.p8,
                runSpacing: AppSizes.p6,
                children: widget.tags
                    .map((t) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.p8,
                            vertical: AppSizes.p4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: AppSizes.r6,
                          ),
                          child: Text(
                            t,
                            style: TextStyle(fontSize: AppSizes.fontXs),
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
        SizedBox(width: AppSizes.p8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
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
