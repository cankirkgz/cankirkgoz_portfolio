import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/design/atoms/language_selector.dart';
import 'package:my_portfolio/design/atoms/theme_toggle_icon.dart';

class NavigationBarWidget extends StatefulWidget {
  final Function(int)? onItemTap;
  final int selectedIndex;

  const NavigationBarWidget({
    super.key,
    this.onItemTap,
    this.selectedIndex = 0,
  });

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  final List<String> _menuItems = [
    'Ana Sayfa',
    'Hakkımda',
    'Projeler',
    'Yetenekler',
    'Deneyimler',
    'İletişim',
  ];

  void _onItemTap(int index) {
    if (widget.onItemTap != null) {
      widget.onItemTap!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sol taraf - Logo
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.blueText, AppColors.purpleText],
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text(
                'CK',
                style: TextStyle(
                  fontSize: AppSizes.fontL,
                  fontWeight: AppSizes.fontWeightBold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Orta - Menü öğeleri
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _menuItems.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () => _onItemTap(index),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      _menuItems[index],
                      style: TextStyle(
                        fontSize: AppSizes.fontS,
                        color: widget.selectedIndex == index
                            ? AppColors.textPrimary
                            : AppColors.blackText,
                        fontWeight: AppSizes.fontWeightMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Sağ taraf - Dil seçici ve tema değiştirici
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              LanguageSelector(),
              SizedBox(width: 10),
              ThemeToggleIcon(),
            ],
          ),
        ],
      ),
    );
  }
}
