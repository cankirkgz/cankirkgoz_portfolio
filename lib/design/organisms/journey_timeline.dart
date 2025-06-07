import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/design/molecules/timeline_item.dart';

class JourneyTimeline extends StatelessWidget {
  const JourneyTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dikey gradient çizgi (timeline)
        Positioned(
          left: 24, // TimelineItem'daki yıl metni ile hizalı
          top: 0,
          bottom: 0,
          child: Container(
            width: 4, // Çizgi kalınlığı
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.blueText,
                  AppColors.purpleText,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 1.0], // Düz geçiş
              ),
            ),
          ),
        ),

        // Timeline öğeleri
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimelineItem(
              year: '2025',
              title: 'Wedly (Yayında)',
              description:
                  "Flutter ile geliştirdiğim düğün planlayıcı mobil uygulamam Google Play’de yayınlandı.",
              color: AppColors.blueText,
            ),
            TimelineItem(
              year: '2024',
              title: 'Flutter Bootcamp (Ternai)',
              description:
                  "Ternai adlı seyahat bütçeleme uygulamasını 5 kişilik ekiple geliştirerek 100 takım arasında ilk 7'ye girdik. MVVM, Riverpod, AutoRoute gibi yapılarla çalıştık.",
              color: AppColors.blueText,
            ),
            TimelineItem(
              year: '2024',
              title: 'Google Oyun ve Uygulama Akademisi',
              description:
                  'Flutter, girişimcilik ve proje yönetimi alanlarında eğitim aldığım, uygulamalı proje geliştirme odaklı program.',
              color: AppColors.blueText,
            ),
            TimelineItem(
              year: '2022',
              title: '42 Okulu',
              description:
                  'Sınavsız, öğretmensiz ama %100 pratikle yazılım geliştirme becerisi kazandığım eşsiz bir deneyim.',
              color: AppColors.purpleText,
            ),
            TimelineItem(
              year: '2018 – 2024',
              title: 'Matematik Lisans Derecesi (%30 İngilizce)',
              description:
                  'Analitik düşünme, problem çözme ve soyutlama yeteneklerimi geliştirdiğim dört yıllık eğitim süreci.',
              color: AppColors.blueText,
            ),
          ],
        ),
      ],
    );
  }
}
