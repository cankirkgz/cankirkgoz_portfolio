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
        icon: FontAwesomeIcons.flutter,
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
        icon: FontAwesomeIcons.flutter,
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
        icon: FontAwesomeIcons.code,
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
        icon: FontAwesomeIcons.graduationCap,
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
        icon: FontAwesomeIcons.laptopCode,
        iconBg: Colors.green,
        title: 'React Native Intern',
        subtitle: 'Fazla',
        date: 'Ağustos 2023 – Kasım 2023',
        location: 'Uzaktan',
        statusBadge: 'Uzaktan',
        bulletColor: Colors.green,
        points: [
          'Stok takip uygulaması geliştirdim ve test süreçlerine katkı sağladım.',
          'React Native ile mobil arayüzler tasarlayıp veri yönetimini sağladım.',
          'Ekip içi kod incelemelerine katılarak yazılım geliştirme süreçlerini öğrendim.',
        ],
        tags: ['React Native', 'TypeScript', 'REST API', 'Figma', 'Git'],
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          children: [
            // Header section
            _buildHeader(),
            const SizedBox(height: 32),
            // Timeline with animations
            _buildTimeline(entries),
            const SizedBox(height: 32),
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
          'My Journey',
          style: TextStyle(
            fontSize: AppSizes.fontXXXXL,
            fontWeight: AppSizes.fontWeightBold,
            color: Colors.grey[900],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Where I've worked and what I've learned along the way",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSizes.fontL,
            color: Colors.grey[600],
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
              left: centerX - 1,
              top: 0,
              bottom: 0,
              child: Container(width: 2, color: AppColors.primary),
            ),
            Column(
              children: List.generate(entries.length, (i) {
                // Build and animate each entry row
                return _buildAnimatedEntry(
                  i,
                  Container(
                    margin: EdgeInsets.only(bottom: AppSizes.p32.top),
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
                          width: 24,
                          child: Column(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: entries[i].bulletColor,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
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
        constraints: BoxConstraints(maxWidth: centerX - 32),
        child: entry, // actual entry widget
      ),
    );
  }

  /// Banner showing achievements with icons and values
  Widget _buildAchievementBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryPurple]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
class _ExperienceEntry extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Card container with shadow and rounded corners
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: icon + title/subtitle + status badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Icon box with gradient
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [iconBg, iconBg.withOpacity(0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: FaIcon(icon, color: Colors.white)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Entry title
                      Text(title,
                          style: TextStyle(
                              fontSize: AppSizes.fontXL,
                              fontWeight: AppSizes.fontWeightSemiBold)),
                      // Entry subtitle/company
                      Text(subtitle,
                          style: TextStyle(
                              color: iconBg, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: bulletColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(statusBadge,
                    style: TextStyle(
                        color: bulletColor, fontSize: AppSizes.fontXs)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Date text
          Text(date, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 4),
          // Location row with icon
          Row(
            children: [
              const Icon(FontAwesomeIcons.mapMarkerAlt,
                  size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Expanded(
                  child: Text(location,
                      style: TextStyle(color: Colors.grey[600]))),
            ],
          ),
          const SizedBox(height: 12),
          // Bullet points
          ...points.map((p) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.checkCircle,
                        size: 14, color: bulletColor),
                    const SizedBox(width: 6),
                    Expanded(
                        child:
                            Text(p, style: TextStyle(color: Colors.grey[800]))),
                  ],
                ),
              )),
          const SizedBox(height: 12),
          // Tags wrap
          Wrap(
              spacing: 8,
              runSpacing: 6,
              children: tags
                  .map((t) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(t,
                            style: TextStyle(fontSize: AppSizes.fontXs)),
                      ))
                  .toList()),
        ],
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
        FaIcon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Numeric value
            Text(value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.fontXXL,
                    fontWeight: AppSizes.fontWeightBold)),
            // Label below value
            Text(label,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: AppSizes.fontS)),
          ],
        ),
      ],
    );
  }
}
