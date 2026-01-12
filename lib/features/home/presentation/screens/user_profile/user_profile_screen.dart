import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2), // Light beige background
      body: Stack(
        children: [
          // Scrollable Content (including header)
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // 1. Dark Header Background with Glow
                Container(
                  width: double.infinity,
                  height: 380,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0D1211), // Dark almost black
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Neon Green Glow/Wave effect
                      Positioned(
                        top: 100,
                        right: -50,
                        child: Container(
                          width: 400,
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment.center,
                              radius: 0.6,
                              colors: [
                                const Color(0xFF26F05F).withOpacity(0.4),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Header Content
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 40),

                              // Avatar with Glow
                              Container(
                                width: 90,
                                height: 90,
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF26F05F),
                                      Color(0xFF00552E),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF26F05F,
                                      ).withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      'https://i.pravatar.cc/300?img=68',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // User Info
                              Text(
                                'Christopher Holmes',
                                style: GoogleFonts.bebasNeue(
                                  color: Colors.white,
                                  fontSize: 28,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Madrid, ESP',
                                style: GoogleFonts.inter(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Stats Cards Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildStatCard(
                                    icon: Icons.filter_vintage,
                                    iconColor: const Color(0xFF26F05F),
                                    value: '18.000',
                                    label: 'Betterflies',
                                  ),
                                  _buildStatCard(
                                    icon: Icons.monetization_on,
                                    iconColor: const Color(0xFFFFD700),
                                    value: '1200',
                                    label: 'Bettercoins',
                                  ),
                                  _buildStatCard(
                                    icon: Icons.security,
                                    iconColor: const Color(0xFF40E0D0),
                                    value: '\$5.000',
                                    label: 'Protection',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. Content Section (on beige background)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Milestone Journey Card
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 1. Flag Node
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF26F05F,
                                    ).withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Icon(
                                  Icons.flag,
                                  color: Color(0xFF40E0D0),
                                  size: 26,
                                ),
                              ],
                            ),

                            const Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 20,
                            ),

                            // 2. Middle Node
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Transform.rotate(
                                      angle: -0.2,
                                      child: const Icon(
                                        Icons.filter_vintage,
                                        color: Color(0xFF26F05F),
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Transform.rotate(
                                      angle: 0.2,
                                      child: const Icon(
                                        Icons.filter_vintage,
                                        color: Color(0xFF26F05F),
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '100 Betterflies',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                              ],
                            ),

                            const Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 20,
                            ),

                            // 3. Goal Node
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Transform.rotate(
                                  angle: 0.785,
                                  child: Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFFFFD700,
                                      ).withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.movie_creation_outlined,
                                  color: Color(0xFFFFD700),
                                  size: 26,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Donation Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Number of donations you can make with your current Bettercoin balance',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: const Color(0xFF1A1A1A),
                                  height: 1.4,
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey.shade300,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            Text(
                              '4',
                              style: GoogleFonts.bebasNeue(
                                fontSize: 40,
                                color: const Color(0xFF1E2E1E),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.favorite,
                              color: Colors.pinkAccent,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // DSNV Leaderboard Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DSNV Leaderboard',
                                    style: GoogleFonts.bebasNeue(
                                      fontSize: 26,
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'You are in position #10',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Avatar Row
                                  Row(
                                    children: [
                                      _buildLeaderAvatar(
                                        'https://i.pravatar.cc/50?img=12',
                                      ),
                                      _buildLeaderAvatar(
                                        'https://i.pravatar.cc/50?img=13',
                                      ),
                                      _buildLeaderAvatar(
                                        'https://i.pravatar.cc/50?img=14',
                                      ),
                                      _buildLeaderAvatar(
                                        'https://i.pravatar.cc/50?img=15',
                                      ),
                                      _buildLeaderAvatar(
                                        'https://i.pravatar.cc/50?img=16',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Trophy Icon
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(
                                          0xFFFF80EA,
                                        ).withOpacity(0.3),
                                        const Color(
                                          0xFF26F05F,
                                        ).withOpacity(0.3),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                const Icon(
                                  Icons.emoji_events,
                                  size: 50,
                                  color: Color(0xFFFF80EA),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Challenge and Versus Buttons
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Challenge',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 24,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Versus',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 24,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Latest Activities Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Latest activities',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 28,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Hoy',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Activity Items
                          _buildActivityCard(
                            'https://i.pravatar.cc/60?img=9',
                            'Amada',
                            'joined Betterfly. Let\'s welcome her!',
                          ),
                          const SizedBox(height: 12),
                          _buildActivityCard(
                            'https://i.pravatar.cc/60?img=20',
                            'Laura',
                            'made 3 donations to the cause\nSave Trees Planted by wild bees',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Your Week Section
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Week',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 28,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                                Text(
                                  'October 3rd - 10th',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            _buildActivityItem(
                              'Steps',
                              '10,458',
                              '+160',
                              '+10',
                            ),
                            const SizedBox(height: 16),
                            _buildActivityItem(
                              'Meditation',
                              '4 hours',
                              '+100',
                              '+5',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100), // Bottom padding
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      width: 100, // Fixed width for uniformity
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.bebasNeue(
              fontSize: 22,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xFF666666),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String subtitle,
    String score1,
    String score2,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              score1,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.filter_vintage,
              size: 14,
              color: Color(0xFF26F05F),
            ),
            const SizedBox(width: 12),
            Text(
              score2,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.circle, size: 14, color: Color(0xFFFFD700)),
          ],
        ),
      ],
    );
  }

  Widget _buildLeaderAvatar(String imageUrl) {
    return Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildActivityCard(String avatarUrl, String name, String action) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(avatarUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Text Content
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF1A1A1A),
                ),
                children: [
                  TextSpan(
                    text: name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' $action'),
                ],
              ),
            ),
          ),
          // Like Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            child: const Icon(
              Icons.thumb_up_outlined,
              size: 20,
              color: Color(0xFF40E0D0),
            ),
          ),
        ],
      ),
    );
  }
}
