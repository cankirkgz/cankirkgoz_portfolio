import 'package:flutter/material.dart';
import 'package:my_portfolio/design/organisms/navigation_bar_widget.dart';
import 'package:my_portfolio/views/about/about_screen.dart';
import 'package:my_portfolio/views/home/home_screen.dart';
import 'package:my_portfolio/views/journey/experience_screen.dart';
import 'package:my_portfolio/views/projects/projects_screen.dart';
import 'package:my_portfolio/views/skills/skills_screen.dart';
import 'package:my_portfolio/views/contact/contact_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  final List<String> _sections = [
    'Home',
    'About',
    'Projects',
    'Skills',
    'Experience',
    'Contact'
  ];
  int _currentIndex = 0;

  void _goTo(int index) {
    if (index < 0 || index >= _sections.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    setState(() => _currentIndex = index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(), // Daha yumuşak kaydırma
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: [
              HomeScreen(),
              AboutScreen(),
              ProjectsScreen(),
              SkillsScreen(),
              ExperienceScreen(),
              ContactScreen(),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavigationBarWidget(
              selectedIndex: _currentIndex,
              onItemTap: (index) => _goTo(index),
            ),
          ),
        ],
      ),
    );
  }
}
