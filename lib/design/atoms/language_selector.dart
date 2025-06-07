import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';

class LanguageSelector extends StatefulWidget {
  /// Başlangıçta gösterilecek dil kodu ("EN" veya "TR")
  final String initialLanguage;

  /// Dil değiştiğinde tetiklenen geri çağrı
  final ValueChanged<String>? onChanged;

  const LanguageSelector({
    super.key,
    this.initialLanguage = 'EN',
    this.onChanged,
  });

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  // Desteklenen diller
  static const Map<String, String> _languages = {
    'EN': 'English',
    'TR': 'Türkçe',
  };

  late String _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: PopupMenuButton<String>(
        onSelected: (value) {
          setState(() => _current = value);
          widget.onChanged?.call(value);
        },
        tooltip: 'Select language',
        itemBuilder: (context) => _languages.entries
            .map(
              (e) => PopupMenuItem<String>(
                value: e.key,
                child: Text('${e.value}  (${e.key})'),
              ),
            )
            .toList(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, color: AppColors.blackText, size: 22),
            const SizedBox(width: 8),
            Text(
              _current,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackText,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.blackText),
          ],
        ),
      ),
    );
  }
}
