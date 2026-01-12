import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2), // Light beige background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Podium Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0EAE2), // Slightly darker beige for header
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Rank 2 (Left)
                    _buildPodiumAvatar(
                      rank: 2,
                      name: 'Jennifer',
                      imageUrl: 'https://i.pravatar.cc/150?img=5',
                      color: const Color(0xFFFF80EA),
                      size: 90,
                      heightOffset: 0,
                    ),
                    const SizedBox(width: 16),
                    // Rank 1 (Center, Higher)
                    _buildPodiumAvatar(
                      rank: 1,
                      name: 'Christopher',
                      imageUrl: 'https://i.pravatar.cc/150?img=68',
                      color: const Color(0xFF26F05F),
                      size: 110,
                      heightOffset: 40,
                    ),
                    const SizedBox(width: 16),
                    // Rank 3 (Right)
                    _buildPodiumAvatar(
                      rank: 3,
                      name: 'Yu Kyung',
                      imageUrl: 'https://i.pravatar.cc/150?img=9',
                      color: const Color(0xFFE8E81A),
                      size: 90,
                      heightOffset: 0,
                    ),
                  ],
                ),
              ),

              // 2. Leaderboard List Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Challenge Leaderboard',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 28,
                        color: const Color(0xFF1A1A1A),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // List Items
                    _buildLeaderboardItem(1, 'Christopher Holmes', '5.400'),
                    _buildLeaderboardItem(2, 'Jennifer Marples', '5.000'),
                    _buildLeaderboardItem(3, 'Yu Kyung Lee', '4.800'),
                    _buildLeaderboardItem(4, 'Amanda Ferreira', '4.400'),
                    _buildLeaderboardItem(5, 'John Edwards', '4.200'),
                    _buildLeaderboardItem(6, 'Sarah Wilson', '3.950'),
                  ],
                ),
              ),

              // Bottom spacing
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPodiumAvatar({
    required int rank,
    required String name,
    required String imageUrl,
    required Color color,
    required double size,
    required double heightOffset,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: heightOffset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with glowing ring
          Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.3), width: 1),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.2), Colors.white.withOpacity(0.8)],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipOval(
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 12), // Space between avatar and badge
          // Badge
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: GoogleFonts.bebasNeue(
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
          ),

          // 3D Podium Base Effect (Optional visual anchor)
          Transform.translate(
            offset: const Offset(0, -16), // Pull up behind badge
            child: Container(
              width: size * 0.8,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.grey.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(int rank, String name, String score) {
    Color rankColor;
    if (rank == 1) {
      rankColor = const Color(0xFF26F05F);
    } else if (rank == 2) {
      rankColor = const Color(0xFFFF80EA);
    } else if (rank == 3) {
      rankColor = const Color(0xFFE8E81A);
    } else {
      rankColor = Colors.transparent;
    }

    bool isTop3 = rank <= 3;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          // Rank Circle
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isTop3 ? rankColor : Colors.grey[100],
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: GoogleFonts.bebasNeue(
                  fontSize: 20,
                  color: isTop3
                      ? Colors.black.withOpacity(0.8)
                      : Colors.black54,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Name
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1A1A1A),
              ),
            ),
          ),

          // Score
          Row(
            children: [
              Text(
                score,
                style: GoogleFonts.bebasNeue(
                  fontSize: 20,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(width: 8),
              // Butterfly Icon match
              const Icon(
                Icons.filter_vintage,
                size: 16,
                color: Color(0xFF26F05F),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
