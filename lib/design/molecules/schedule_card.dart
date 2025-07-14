import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/design/atoms/rounded_button.dart';
import 'package:my_portfolio/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primaryPurple.withOpacity(0.1)
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryPurple],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: FaIcon(FontAwesomeIcons.calendarDays,
                  color: Colors.white, size: 28),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            appLocalizations.scheduleCallTitle,
            style: const TextStyle(
              fontSize: AppSizes.fontXL,
              fontWeight: AppSizes.fontWeightSemiBold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            appLocalizations.scheduleCallSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizes.fontM,
              color: AppColors.textPrimary(context).withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 16),
          RoundedButton(
            firstText: appLocalizations.scheduleCallButton,
            onPressed: () => _launchURL('https://calendly.com/mcankirkgoz'),
            type: ButtonType.outline,
            textColor: const Color(0xFF6366F1),
            borderColor: const Color(0xFF6366F1),
            borderWidth: 2,
          ),
        ],
      ),
    );
  }
}
