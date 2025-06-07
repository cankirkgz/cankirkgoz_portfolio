import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class Footer extends StatelessWidget {
  final Function(int)? onItemTap;
  const Footer({Key? key, this.onItemTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E293B),
      padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
      margin: const EdgeInsets.only(top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Üst satır: Sol - Kimlik, Sağ - Menü
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sol taraf
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Can Kırkgöz',
                      style: TextStyle(
                        fontSize: AppSizes.fontXL,
                        fontWeight: AppSizes.fontWeightBold,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [
                              AppColors.blueText,
                              AppColors.purpleText,
                            ],
                          ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mobil Geliştirici · Flutter Geliştirici · Problem Çözücü',
                      style: TextStyle(
                        fontSize: AppSizes.fontS,
                        color: AppColors.textLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '© 2025 Can Kırkgöz. Tüm hakları saklıdır.',
                      style: TextStyle(
                        fontSize: AppSizes.fontS,
                        color: AppColors.icon,
                      ),
                    ),
                  ],
                ),
              ),

              // Sağ taraf: Menü
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      _footerLink(0, 'Ana Sayfa', onItemTap),
                      _footerLink(1, 'Hakkımda', onItemTap),
                      _footerLink(2, 'Projeler', onItemTap),
                      _footerLink(3, 'Yetenekler', onItemTap),
                      _footerLink(4, 'Deneyimler', onItemTap),
                      _footerLink(5, 'İletişim', onItemTap),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _socialIcon(FontAwesomeIcons.github),
                      _socialIcon(FontAwesomeIcons.linkedinIn),
                      _socialIcon(FontAwesomeIcons.envelope),
                      _socialIcon(FontAwesomeIcons.twitter),
                    ],
                  )
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),
          Divider(color: Colors.grey.shade700),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF6366F1),
                child: Icon(
                  FontAwesomeIcons.arrowUp,
                  size: 14,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _footerLink(int index, String label, Function(int)? onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () => onTap?.call(index),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            label,
            style: TextStyle(
              fontSize: AppSizes.fontS,
              color: Colors.grey.shade300,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.grey.shade800,
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}
