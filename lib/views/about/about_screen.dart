import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/design/atoms/profile_avatar.dart';
import 'package:my_portfolio/design/molecules/certificate_card.dart';
import 'package:my_portfolio/design/molecules/quote_card.dart';
import 'package:my_portfolio/design/molecules/tech_icon_card.dart';
import 'package:my_portfolio/design/molecules/text_card.dart';
import 'package:my_portfolio/design/organisms/journey_timeline.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Animation<Offset>> _slideAnims = [];
  final List<Animation<double>> _fadeAnims = [];
  final int _itemCount = 11;

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
        Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        ),
      );
      _fadeAnims.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeIn),
          ),
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
    const sampleText = '''
Ben Can, Ankara, Türkiye'de yaşayan bir mobil uygulama geliştiricisiyim. Flutter, Kotlin ve Firebase kullanarak yüksek kaliteli mobil uygulamalar geliştirme konusunda uzmanlaştım. Fikirleri çalışan ürünlere dönüştürmeyi ve yazılım geliştirme sürecindeki tasarım, kodlama ve problem çözme aşamalarını çok seviyorum.

Kodlamanın dışında, gitar çalmayı, yazı yazmayı ve kedim Misha ile vakit geçirmeyi seviyorum. Sürekli öğrenmeye ve iş birliği içinde çalışmaya inanıyorum.
''';

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isSmall = width < 800;
        // Responsive horizontal padding & vertical spacing
        final horizontalPadding = isSmall ? AppSizes.p16 : AppSizes.p120;
        final verticalPadding = isSmall ? AppSizes.p32 : AppSizes.p80;
        // Responsive avatar size for About screen
        final avatarSize = isSmall ? (width * 0.6).clamp(120.0, 200.0) : 320.0;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isSmall ? AppSizes.p24 : AppSizes.p48),

                // 1) Profile + Text
                _animItem(
                  1,
                  isSmall
                      ? Column(
                          children: [
                            ProfileAvatar(
                              image: const AssetImage(
                                  'assets/images/my_photo_second.jpg'),
                              showBadge: true,
                              badgeTags: const [
                                'Mobile Developer',
                                'Flutter',
                                'Firebase'
                              ],
                              showBorder: false,
                              size: avatarSize,
                            ),
                            const SizedBox(height: AppSizes.p24),
                            TextCard(text: sampleText),
                          ],
                        )
                      : Row(
                          children: [
                            ProfileAvatar(
                              image: const AssetImage(
                                  'assets/images/my_photo_second.jpg'),
                              showBadge: true,
                              badgeTags: const [
                                'Mobile Developer',
                                'Flutter',
                                'Firebase'
                              ],
                              showBorder: false,
                              size: avatarSize,
                            ),
                            const SizedBox(width: AppSizes.p32),
                            Expanded(child: TextCard(text: sampleText)),
                          ],
                        ),
                ),

                SizedBox(height: isSmall ? AppSizes.p32 : AppSizes.p64),

                // 2) Technologies Title
                _animItem(
                  2,
                  Text(
                    'Kullandığım Teknolojiler',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSizes.fontXL,
                      fontWeight: AppSizes.fontWeightSemiBold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.p24),

                // 3) Tech Icons
                _animItem(
                  3,
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppSizes.p20,
                    runSpacing: AppSizes.p16,
                    children: const [
                      TechIconCard(
                          iconPath: 'assets/icons/flutter_icon.png',
                          label: 'Flutter'),
                      TechIconCard(
                          iconPath: 'assets/icons/dart_icon.png',
                          label: 'Dart'),
                      TechIconCard(
                          iconPath: 'assets/icons/kotlin_icon.png',
                          label: 'Kotlin'),
                      TechIconCard(
                          iconPath: 'assets/icons/firebase_icon.png',
                          label: 'Firebase'),
                      TechIconCard(
                          iconPath: 'assets/icons/git_icon.png', label: 'Git'),
                      TechIconCard(
                          iconPath: 'assets/icons/figma_icon.png',
                          label: 'Figma'),
                      TechIconCard(
                          iconPath: 'assets/icons/hive_icon.png',
                          label: 'Hive'),
                      TechIconCard(
                          iconPath: 'assets/icons/riverpod_icon.png',
                          label: 'Riverpod'),
                    ],
                  ),
                ),

                SizedBox(height: isSmall ? AppSizes.p32 : AppSizes.p64),

                // 4) Journey Title
                _animItem(
                  4,
                  Text(
                    'Şu Ana Kadarki Yolculuğum',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSizes.fontXL,
                      fontWeight: AppSizes.fontWeightSemiBold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.p24),

                // 5) Journey Timeline
                _animItem(5, JourneyTimeline()),

                SizedBox(height: isSmall ? AppSizes.p32 : AppSizes.p64),

                // 6) Certificates Title
                _animItem(
                  6,
                  Text(
                    'Sertifikalarım & Başarılarım',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSizes.fontXL,
                      fontWeight: AppSizes.fontWeightSemiBold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.p24),

                // 7) Certificate Cards (first row)
                _animItem(
                  7,
                  LayoutBuilder(builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    // Kaç sütun?
                    final columns = screenWidth >= 1200
                        ? 3
                        : screenWidth >= 800
                            ? 2
                            : 1;
                    final spacing = AppSizes.p24;
                    final totalSpacing = spacing * (columns - 1);
                    final cardWidth = (screenWidth - totalSpacing) / columns;

                    final firstRow = [
                      CertificateCard(
                        icon: FontAwesomeIcons.lightbulb,
                        iconColor: AppColors.primaryblue,
                        title: "Ideathon",
                        subtitle: "Google Oyun ve Uygulama Akademisi",
                        description:
                            "Fikir üretme, takım çalışması ve sunum teknikleri alanında yoğun bir fikir maratonuna katıldım.",
                        year: "2024",
                        yearColor: AppColors.primaryblue,
                      ),
                      CertificateCard(
                        icon: FontAwesomeIcons.rocket,
                        iconColor: AppColors.certOrange,
                        title: "App-Jam",
                        subtitle: "Google Oyun ve Uygulama Akademisi",
                        description:
                            "3 gün içinde takım çalışmasıyla prototip bir mobil uygulama geliştirip sunduğumuz hızlı geliştirme maratonu.",
                        year: "2024",
                        yearColor: AppColors.certOrange,
                      ),
                      CertificateCard(
                        icon: FontAwesomeIcons.robot,
                        iconColor: AppColors.certGreen,
                        title: "AI Destekli App-Jam",
                        subtitle: "Google Oyun ve Uygulama Akademisi",
                        description:
                            "Yapay zekayı entegre ettiğimiz, 4 günlük bir uygulama geliştirme sürecinde ekip olarak yenilikçi bir prototip oluşturduk.",
                        year: "2024",
                        yearColor: AppColors.certGreen,
                      ),
                    ];

                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: spacing,
                      runSpacing: spacing,
                      children: firstRow.map((card) {
                        return SizedBox(
                          width: cardWidth,
                          child: card,
                        );
                      }).toList(),
                    );
                  }),
                ),

                SizedBox(height: AppSizes.p24),

// 8) Sertifika Kartları—ikinci grup
                _animItem(
                  8,
                  LayoutBuilder(builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    final columns = screenWidth >= 1200
                        ? 3
                        : screenWidth >= 800
                            ? 2
                            : 1;
                    final spacing = AppSizes.p24;
                    final totalSpacing = spacing * (columns - 1);
                    final cardWidth = (screenWidth - totalSpacing) / columns;

                    final secondRow = [
                      CertificateCard(
                        icon: FontAwesomeIcons.clipboardCheck,
                        iconColor: AppColors.certLightBlue,
                        title: "Proje Yöneticisi",
                        subtitle: "Google",
                        description:
                            "Google Proje Yönetimi eğitimi kapsamında; planlama, zaman yönetimi, ekip koordinasyonu ve Agile metodolojileri üzerine kapsamlı bilgi edindim.",
                        year: "2024",
                        yearColor: AppColors.certLightBlue,
                      ),
                      CertificateCard(
                        icon: FontAwesomeIcons.code,
                        iconColor: AppColors.certDarkBlue,
                        title: "Dart Programlama Dili",
                        subtitle: "BTK Akademi",
                        description:
                            "Dart programlama dilinin temellerini öğrendim. Flutter geliştirme sürecinde ihtiyaç duyduğum tüm temel konulara hakimiyet kazandım.",
                        year: "2024",
                        yearColor: AppColors.certDarkBlue,
                      ),
                      CertificateCard(
                        icon: FontAwesomeIcons.graduationCap,
                        iconColor: AppColors.certYellow,
                        title: "Bootcamp",
                        subtitle: "Google Oyun ve Uygulama Akademisi",
                        description:
                            "Flutter, girişimcilik ve proje yönetimi alanlarında kapsamlı eğitim aldığım, uygulamalı proje geliştirme temelli yoğun eğitim programı.",
                        year: "2024",
                        yearColor: AppColors.certYellow,
                      ),
                    ];

                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: spacing,
                      runSpacing: spacing,
                      children: secondRow.map((card) {
                        return SizedBox(
                          width: cardWidth,
                          child: card,
                        );
                      }).toList(),
                    );
                  }),
                ),

                SizedBox(height: isSmall ? AppSizes.p32 : AppSizes.p40),

                // 9) Quote
                _animItem(
                  9,
                  const QuoteCard(
                    quote:
                        '"Code is like poetry – when written with care, it flows beautifully."',
                  ),
                ),

                SizedBox(height: isSmall ? AppSizes.p32 : AppSizes.p48),
              ],
            ),
          ),
        );
      },
    );
  }
}
