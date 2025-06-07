import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/design/atoms/profile_avatar.dart';
import 'package:my_portfolio/design/molecules/certificate_card.dart';
import 'package:my_portfolio/design/molecules/quote_card.dart';
import 'package:my_portfolio/design/molecules/tech_icon_card.dart';
import 'package:my_portfolio/design/molecules/text_card.dart';
import 'package:my_portfolio/design/organisms/journey_timeline.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
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
    const sampleText = '''
Ben Can, Ankara, Türkiye'de yaşayan bir mobil uygulama geliştiricisiyim. Flutter, Kotlin ve Firebase kullanarak yüksek kaliteli mobil uygulamalar geliştirme konusunda uzmanlaştım. Fikirleri çalışan ürünlere dönüştürmeyi ve yazılım geliştirme sürecindeki tasarım, kodlama ve problem çözme aşamalarını çok seviyorum.

Kodlamanın dışında, gitar çalmayı, yazı yazmayı ve kedim Misha ile vakit geçirmeyi seviyorum. Sürekli öğrenmeye ve iş birliği içinde çalışmaya inanıyorum.
''';

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 80.0),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _animItem(
              0,
              Text(
                'Hakkımda',
                style: TextStyle(
                  fontSize: AppSizes.fontXXXXL,
                  fontWeight: AppSizes.fontWeightBold,
                  color: const Color(0xFF111827),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _animItem(
              1,
              Text(
                'Geliştirici olarak kısa bir tanıtım',
                style: TextStyle(
                  fontSize: AppSizes.fontL,
                  fontWeight: AppSizes.fontWeightRegular,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ),
            const SizedBox(height: 48),
            _animItem(
              2,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileAvatar(
                    image: AssetImage('assets/images/profile.jpg'),
                    showBadge: true,
                    badgeTags: ['Mobile Developer', 'Flutter', 'Firebase'],
                    showBorder: false,
                  ),
                  const Spacer(),
                  Expanded(child: TextCard(text: sampleText)),
                ],
              ),
            ),
            const SizedBox(height: 64),
            _animItem(
              3,
              Text(
                'Kullandığım Teknolojiler',
                style: TextStyle(
                  fontSize: AppSizes.fontXL,
                  fontWeight: AppSizes.fontWeightSemiBold,
                  color: const Color(0xFF111827),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _animItem(
              4,
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 40,
                runSpacing: 20,
                children: const [
                  TechIconCard(
                      iconPath: 'assets/icons/flutter_icon.png',
                      label: 'Flutter'),
                  TechIconCard(
                      iconPath: 'assets/icons/dart_icon.png', label: 'Dart'),
                  TechIconCard(
                      iconPath: 'assets/icons/kotlin_icon.png',
                      label: 'Kotlin'),
                  TechIconCard(
                      iconPath: 'assets/icons/firebase_icon.png',
                      label: 'Firebase'),
                  TechIconCard(
                      iconPath: 'assets/icons/git_icon.png', label: 'Git'),
                  TechIconCard(
                      iconPath: 'assets/icons/figma_icon.png', label: 'Figma'),
                  TechIconCard(
                      iconPath: 'assets/icons/hive_icon.png', label: 'Hive'),
                  TechIconCard(
                      iconPath: 'assets/icons/riverpod_icon.png',
                      label: 'Riverpod'),
                ],
              ),
            ),
            const SizedBox(height: 64),
            _animItem(
              5,
              Text(
                'Şu Ana Kadarki Yolculuğum',
                style: TextStyle(
                  fontSize: AppSizes.fontXL,
                  fontWeight: AppSizes.fontWeightSemiBold,
                  color: const Color(0xFF111827),
                ),
              ),
            ),
            const SizedBox(height: 40),
            _animItem(6, JourneyTimeline()),
            const SizedBox(height: 64),
            _animItem(
              7,
              Text(
                'Sertifikalarım & Başarılarım',
                style: TextStyle(
                  fontSize: AppSizes.fontXL,
                  fontWeight: AppSizes.fontWeightSemiBold,
                  color: const Color(0xFF111827),
                ),
              ),
            ),
            const SizedBox(height: 40),
            _animItem(
              8,
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final cardCount = 3; // Kart sayısı
                  final spacing = 24.0; // Kartlar arası boşluk
                  final totalSpacing = spacing * (cardCount - 1);
                  final availableWidth = screenWidth - totalSpacing;
                  final cardWidth = availableWidth / cardCount;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: CertificateCard(
                          icon: FontAwesomeIcons.lightbulb,
                          iconColor: Color(0xFF2563EB),
                          title: "Ideathon",
                          subtitle: "Google Oyun ve Uygulama Akademisi",
                          description:
                              "Fikir üretme, takım çalışması ve sunum teknikleri alanında yoğun bir fikir maratonuna katıldım.",
                          year: "2024",
                          yearColor: Color(0xFF2563EB),
                        ),
                      ),
                      SizedBox(width: spacing),
                      SizedBox(
                        width: cardWidth,
                        child: CertificateCard(
                          icon: FontAwesomeIcons.rocket,
                          iconColor: Color(0xFFEA580C),
                          title: "App-Jam",
                          subtitle: "Google Oyun ve Uygulama Akademisi",
                          description:
                              "3 gün içinde takım çalışmasıyla prototip bir mobil uygulama geliştirip sunduğumuz hızlı geliştirme maratonu.",
                          year: "2024",
                          yearColor: Color(0xFFEA580C),
                        ),
                      ),
                      SizedBox(width: spacing),
                      SizedBox(
                        width: cardWidth,
                        child: CertificateCard(
                          icon: FontAwesomeIcons.robot,
                          iconColor: Color(0xFF16A34A),
                          title: "AI Destekli App-Jam",
                          subtitle: "Google Oyun ve Uygulama Akademisi",
                          description:
                              "Yapay zekayı entegre ettiğimiz, 4 günlük bir uygulama geliştirme sürecinde ekip olarak yenilikçi bir prototip oluşturduk.",
                          year: "2024",
                          yearColor: Color(0xFF16A34A),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _animItem(
              9,
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = constraints.maxWidth;
                  final cardCount = 3; // Bu satırdaki kart sayısı
                  final spacing = 24.0; // Kartlar arası boşluk
                  final totalSpacing = spacing * (cardCount - 1);
                  final availableWidth = screenWidth - totalSpacing;
                  final cardWidth = availableWidth / cardCount;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: CertificateCard(
                          icon: FontAwesomeIcons.clipboardCheck,
                          iconColor: Color(0xFF61DAFB),
                          title: "Proje Yöneticisi",
                          subtitle: "Google",
                          description:
                              "Google Proje Yönetimi eğitimi kapsamında; planlama, zaman yönetimi, ekip koordinasyonu ve Agile metodolojileri üzerine kapsamlı bilgi edindim.",
                          year: "2024",
                          yearColor: Color(0xFF61DAFB),
                        ),
                      ),
                      SizedBox(width: spacing),
                      SizedBox(
                        width: cardWidth,
                        child: CertificateCard(
                          icon: FontAwesomeIcons.code,
                          iconColor: Color(0xFF3776AB),
                          title: "Dart Programlama Dili",
                          subtitle: "BTK Akademi",
                          description:
                              "Dart programlama dilinin temellerini öğrendim. Flutter geliştirme sürecinde ihtiyaç duyduğum tüm temel konulara hakimiyet kazandım.",
                          year: "2024",
                          yearColor: Color(0xFF3776AB),
                        ),
                      ),
                      SizedBox(width: spacing),
                      SizedBox(
                        width: cardWidth,
                        child: CertificateCard(
                          icon: FontAwesomeIcons.graduationCap,
                          iconColor: Color(0xFFFF9900),
                          title: "Bootcamp",
                          subtitle: "Google Oyun ve Uygulama Akademisi",
                          description:
                              "Flutter, girişimcilik ve proje yönetimi alanlarında kapsamlı eğitim aldığım, uygulamalı proje geliştirme temelli yoğun eğitim programı.",
                          year: "2021",
                          yearColor: Color(0xFFFF9900),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            _animItem(
              10,
              QuoteCard(
                quote:
                    '"Code is like poetry – when written with care, it flows beautifully."',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
