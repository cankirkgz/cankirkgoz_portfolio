import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final Function(int)? onItemTap;
  const Footer({Key? key, this.onItemTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                        _buildIdentitySection(context, l10n),
                        const SizedBox(height: 24),
                        _buildMenuSection(isMobile, l10n),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sol taraf
                        Expanded(child: _buildIdentitySection(context, l10n)),
                        // Sağ taraf: Menü
                        _buildMenuSection(isMobile, l10n),
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

  Widget _buildIdentitySection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.footerName,
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
          l10n.footerTitle,
          style: TextStyle(
            fontSize: AppSizes.fontS,
            color: AppColors.textLight(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.footerCopyright,
          style: TextStyle(
            fontSize: AppSizes.fontS,
            color: AppColors.icon(context),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(bool isMobile, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Wrap(
          alignment: isMobile ? WrapAlignment.start : WrapAlignment.end,
          spacing: 16,
          runSpacing: 8,
          children: [
            _footerLink(0, l10n.footerHome, onItemTap),
            _footerLink(1, l10n.footerAbout, onItemTap),
            _footerLink(2, l10n.footerProjects, onItemTap),
            _footerLink(3, l10n.footerSkills, onItemTap),
            _footerLink(4, l10n.footerExperience, onItemTap),
            _footerLink(5, l10n.footerContact, onItemTap),
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

  Future<void> _launchURL(String url) async {
    if (kIsWeb) {
      // Web platformu için
      final uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Mobil platformlar için
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _launchURL(widget.url),
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
