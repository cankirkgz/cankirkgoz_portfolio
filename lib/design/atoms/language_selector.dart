import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/core/providers/locale_provider.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: Icon(
        Icons.language,
        color: AppColors.icon(context),
      ),
      onSelected: (Locale locale) {
        context.read<LocaleProvider>().setLocale(locale);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: const Locale('tr'),
          child: Text('Türkçe',
              style: TextStyle(color: AppColors.textPrimary(context))),
        ),
        PopupMenuItem(
          value: const Locale('en'),
          child: Text('English',
              style: TextStyle(color: AppColors.textPrimary(context))),
        ),
      ],
    );
  }
}
