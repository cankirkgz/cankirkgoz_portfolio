import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/core/providers/locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language),
      onSelected: (Locale locale) {
        context.read<LocaleProvider>().setLocale(locale);
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: Locale('tr'),
          child: Text('Türkçe'),
        ),
        const PopupMenuItem(
          value: Locale('en'),
          child: Text('English'),
        ),
      ],
    );
  }
}
