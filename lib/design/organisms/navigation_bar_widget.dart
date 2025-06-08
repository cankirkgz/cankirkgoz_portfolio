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
    widget.onItemTap?.call(index);
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ← full-height & scroll
      backgroundColor: Theme.of(context).canvasColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: SingleChildScrollView(
            // ← Sığmayan içeriği scroll’la
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.p16, vertical: AppSizes.p8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Menü öğeleri
                  ...List.generate(_menuItems.length, (i) {
                    return ListTile(
                      title: Text(
                        _menuItems[i],
                        style: TextStyle(
                          fontSize: AppSizes.fontM,
                          fontWeight: widget.selectedIndex == i
                              ? AppSizes.fontWeightBold
                              : AppSizes.fontWeightMedium,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(ctx);
                        _onItemTap(i);
                      },
                    );
                  }),
                  const Divider(),
                  // Dil seçici
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: LanguageSelector(),
                  ),
                  // Tema toggle
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ThemeToggleIcon(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final isMobile = width < 900; // <<< Eşiği 800 → 900 yaptık
      final horizontalPadding = isMobile
          ? AppSizes.p8 // darda sadece 8px padding
          : AppSizes.p32; // genişte 32px padding

      return Container(
        height: 64,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.blueText, AppColors.purpleText],
                ),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Text(
                  'CK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppSizes.fontL,
                    fontWeight: AppSizes.fontWeightBold,
                  ),
                ),
              ),
            ),

            if (!isMobile) ...[
              // Masaüstü menü
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_menuItems.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.p24),
                        child: GestureDetector(
                          onTap: () => _onItemTap(index),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Text(
                              _menuItems[index],
                              style: TextStyle(
                                fontSize: AppSizes.fontS,
                                color: widget.selectedIndex == index
                                    ? Colors.black
                                    : AppColors.blackText,
                                fontWeight: widget.selectedIndex == index
                                    ? AppSizes.fontWeightBold
                                    : AppSizes.fontWeightMedium,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              // Dil seçici + tema
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  LanguageSelector(),
                  SizedBox(width: AppSizes.p12),
                  ThemeToggleIcon(),
                ],
              ),
            ] else ...[
              // Mobil hamburger
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _showMobileMenu(context),
              ),
            ],
          ],
        ),
      );
    });
  }
}
