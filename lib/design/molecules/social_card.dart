import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow(context).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.border(context)),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.contactSocialCardTitle,
            style: TextStyle(
              fontSize: AppSizes.fontXXL,
              fontWeight: AppSizes.fontWeightSemiBold,
              color: AppColors.textPrimary(context),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _SocialItem(
                icon: FontAwesomeIcons.github,
                background: Colors.black,
                label: appLocalizations.github,
                sublabel: '@cankirkgz',
                color: Colors.white,
                url: 'https://github.com/cankirkgz',
              ),
              _SocialItem(
                icon: FontAwesomeIcons.linkedinIn,
                background: const Color(0xFF0A66C2),
                label: appLocalizations.linkedin,
                sublabel: '@cankirkgoz99',
                color: Colors.white,
                url: 'https://www.linkedin.com/in/cankirkgoz99/',
              ),
              _SocialItem(
                icon: FontAwesomeIcons.envelope,
                background: const Color(0xFFE53E3E),
                label: appLocalizations.email,
                sublabel: appLocalizations.directEmail,
                color: Colors.white,
                url: 'mailto:mcankirkgoz@gmail.com',
              ),
              _SocialItem(
                icon: FontAwesomeIcons.medium,
                background: const Color(0xFF1DA1F2),
                label: appLocalizations.medium,
                sublabel: '@mcankirkgoz',
                color: Colors.white,
                url: 'https://medium.com/@mcankirkgoz',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialItem extends StatefulWidget {
  final IconData icon;
  final Color background;
  final String label;
  final String sublabel;
  final Color color;
  final String url;

  const _SocialItem({
    required this.icon,
    required this.background,
    required this.label,
    required this.sublabel,
    required this.color,
    required this.url,
  });

  @override
  State<_SocialItem> createState() => _SocialItemState();
}

class _SocialItemState extends State<_SocialItem> {
  bool _isHovered = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _launchURL(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
          child: Container(
            width: 160,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.grey(context),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered ? widget.background : AppColors.grey(context),
                width: _isHovered ? 2 : 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: widget.background.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: widget.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: FaIcon(widget.icon, color: widget.color),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary(context)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.sublabel,
                        style: TextStyle(
                          fontSize: AppSizes.fontXs,
                          color:
                              AppColors.textPrimary(context).withOpacity(0.6),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
