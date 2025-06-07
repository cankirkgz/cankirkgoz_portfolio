import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/design/atoms/rounded_button.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              gradient: LinearGradient(
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
            'Görüşme Planla',
            style: TextStyle(
              fontSize: AppSizes.fontXL,
              fontWeight: AppSizes.fontWeightSemiBold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Yazışmak yerine konuşmayı mı tercih ediyorsunuz? Projenizi konuşmak için hızlı bir 15 dakikalık görüşme planlayalım.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizes.fontM,
              color: AppColors.textPrimary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 16),
          RoundedButton(
            firstText: "Görüşme Ayarla",
            onPressed: () {},
            type: ButtonType.outline,
            textColor: Color(0xFF6366F1),
            borderColor: Color(0xFF6366F1),
            borderWidth: 2,
          ),
        ],
      ),
    );
  }
}
