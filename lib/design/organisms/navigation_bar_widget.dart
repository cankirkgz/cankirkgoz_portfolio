import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/design/atoms/language_selector.dart';
import 'package:my_portfolio/design/atoms/theme_toggle_icon.dart';
import 'package:my_portfolio/l10n/app_localizations.dart';

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
  List<String> get _menuItems => [
        AppLocalizations.of(context)!.home,
        AppLocalizations.of(context)!.about,
        AppLocalizations.of(context)!.projects,
        AppLocalizations.of(context)!.skills,
        AppLocalizations.of(context)!.experience,
        AppLocalizations.of(context)!.contact,
      ];

  void _onItemTap(int index) {
    widget.onItemTap?.call(index);
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldBackground(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.p16, vertical: AppSizes.p8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(_menuItems.length, (i) {
                    return ListTile(
                      title: Text(
                        _menuItems[i],
                        style: TextStyle(
                          fontSize: AppSizes.fontM,
                          fontWeight: widget.selectedIndex == i
                              ? AppSizes.fontWeightBold
                              : AppSizes.fontWeightMedium,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(ctx);
                        _onItemTap(i);
                      },
                    );
                  }),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: LanguageSelector(),
                  ),
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
      final isMobile = width < 900;
      final horizontalPadding = isMobile ? AppSizes.p8 : AppSizes.p32;

      return Container(
        height: 64,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        color: AppColors.scaffoldBackground(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
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
                                    ? AppColors.textPrimary(context)
                                    : AppColors.textSecondary(context),
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
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LanguageSelector(),
                  SizedBox(width: AppSizes.p12),
                  ThemeToggleIcon(),
                ],
              ),
            ] else ...[
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
