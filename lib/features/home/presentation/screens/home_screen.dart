import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'main/main_screen.dart';
import 'explore/explore_screen.dart';
import 'challenges/challenges_screen.dart';
import 'user_profile/user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String language;
  final bool isRTL;

  const HomeScreen({super.key, required this.language, required this.isRTL});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    MainScreen(),
    ExploreScreen(),
    ChallengesScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf4fdf7),
      body: Stack(
        children: [
          // 1. Content Layer
          Positioned.fill(
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),

          // 2. Custom Floating Bottom Navigation Bar
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: CustomBottomNavBar(
              selectedIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}
