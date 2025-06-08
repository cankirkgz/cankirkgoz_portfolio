import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';

class Footer extends StatelessWidget {
  final Function(int)? onItemTap;
  const Footer({Key? key, this.onItemTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          color: const Color(0xFF1E293B),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          margin: const EdgeInsets.only(top: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Üst satır: Sol - Kimlik, Sağ - Menü
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIdentitySection(),
                        const SizedBox(height: 24),
                        _buildMenuSection(isMobile),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sol taraf
                        Expanded(child: _buildIdentitySection()),
                        // Sağ taraf: Menü
                        _buildMenuSection(isMobile),
                      ],
                    ),
              const SizedBox(height: 24),
              Divider(color: Colors.grey.shade700),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => onItemTap?.call(0),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF6366F1),
                        child: const Icon(
                          FontAwesomeIcons.arrowUp,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildIdentitySection() {
    return Column(
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
              ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
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
    );
  }

  Widget _buildMenuSection(bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Wrap(
          alignment: isMobile ? WrapAlignment.start : WrapAlignment.end,
          spacing: 16,
          runSpacing: 8,
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
        Wrap(
          spacing: 12,
          runSpacing: 8,
          alignment: isMobile ? WrapAlignment.start : WrapAlignment.end,
          children: [
            _SocialIcon(
                FontAwesomeIcons.github, 'https://github.com/cankirkgz'),
            _SocialIcon(FontAwesomeIcons.linkedinIn,
                'https://www.linkedin.com/in/cankirkgoz99/'),
            _SocialIcon(
                FontAwesomeIcons.envelope, 'mailto:mcankirkgoz@gmail.com'),
            _SocialIcon(
                FontAwesomeIcons.medium, 'https://medium.com/@mcankirkgoz'),
          ],
        )
      ],
    );
  }

  Widget _footerLink(int index, String label, Function(int)? onTap) {
    return GestureDetector(
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
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialIcon(this.icon, this.url);

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => html.window.open(widget.url, '_blank'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
          child: CircleAvatar(
            radius: 18,
            backgroundColor:
                _isHovered ? AppColors.primaryPurple : Colors.grey.shade800,
            child: Icon(widget.icon, size: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
