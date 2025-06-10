import 'package:flutter/material.dart';
import 'package:my_portfolio/design/organisms/navigation_bar_widget.dart';
import 'package:my_portfolio/views/about/about_screen.dart';
import 'package:my_portfolio/views/footer/footer.dart';
import 'package:my_portfolio/views/home/home_screen.dart';
import 'package:my_portfolio/views/journey/experience_screen.dart';
import 'package:my_portfolio/views/projects/projects_screen.dart';
import 'package:my_portfolio/views/skills/skills_screen.dart';
import 'package:my_portfolio/views/contact/contact_screen.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(7, (_) => GlobalKey());
  int _currentIndex = 0;

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onScroll() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero).dy;
        if (offset >= 0 && offset < MediaQuery.of(context).size.height / 2) {
          setState(() => _currentIndex = i);
          break;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                HomeScreen(
                  key: _sectionKeys[0],
                  onProjectsTap: () => _scrollToSection(2),
                ),
                AboutScreen(key: _sectionKeys[1]),
                ProjectsScreen(key: _sectionKeys[2]),
                SkillsScreen(key: _sectionKeys[3]),
                ExperienceScreen(key: _sectionKeys[4]),
                ContactScreen(key: _sectionKeys[5]),
                Footer(
                  key: _sectionKeys[6],
                  onItemTap: _scrollToSection,
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavigationBarWidget(
              selectedIndex: _currentIndex,
              onItemTap: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}
