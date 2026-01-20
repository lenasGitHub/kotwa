import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/challenges_data.dart';
import '../widgets/challenge_card.dart';
import 'challenge_detail_screen.dart';

class MyLandScreen extends StatelessWidget {
  const MyLandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final challenges = ChallengesData.getEnrolled();
    // Gold theme for "My Land"
    final themeColor = const Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Dark background
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: const Color(0xFF1A1A1A),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      themeColor.withOpacity(0.2),
                      const Color(0xFF1A1A1A),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: themeColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: themeColor.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.landscape,
                          size: 40,
                          color: themeColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'My Land',
                        style: GoogleFonts.cairo(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Enrolled Challenges List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final challenge = challenges[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ChallengeCard(
                    challenge: challenge,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChallengeDetailScreen(challenge: challenge),
                        ),
                      );
                    },
                  ),
                );
              }, childCount: challenges.length),
            ),
          ),

          // Empty State
          if (challenges.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.agriculture,
                      size: 64,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your land is empty',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join challenges to cultivate your land',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
