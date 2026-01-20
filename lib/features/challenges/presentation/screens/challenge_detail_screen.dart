import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/challenge.dart';
import '../../domain/models/tracking_type.dart';
import '../widgets/tracking/tracking_widget_factory.dart';
import '../widgets/social_reactions_bar.dart';
import '../../../../core/services/api_service.dart';

/// Detail screen for a specific challenge with tracking and social features
class ChallengeDetailScreen extends StatefulWidget {
  final Challenge challenge;

  const ChallengeDetailScreen({super.key, required this.challenge});

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  bool _isJoined = false;
  bool _isCompleted = false;

  Future<void> _joinChallenge() async {
    final response = await ApiService.joinChallenge(widget.challenge.id);
    if (response.isSuccess) {
      setState(() => _isJoined = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Joined challenge successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error ?? 'Failed to join')),
      );
    }
  }

  Future<void> _onComplete(dynamic value) async {
    setState(() => _isCompleted = true);

    // Parse value for API
    double infoValue = 0;
    if (value is num) {
      infoValue = value.toDouble();
    } else if (value is Duration) {
      infoValue = value.inSeconds.toDouble();
    } else if (value is bool && value) {
      infoValue = 1.0;
    }

    final response = await ApiService.logProgress(
      challengeId: widget.challenge.id,
      value: infoValue,
      isSuccess: true,
    );

    if (response.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Progress saved! Keep it up!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error ?? 'Failed to save progress')),
      );
    }
  }

  Future<void> _onPhotoTaken(String? path) async {
    if (path == null) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Uploading photo...')));

    final response = await ApiService.uploadPhoto(widget.challenge.id, path);

    if (response.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo uploaded successfully!')),
      );
      // Trigger completion if needed, or assume photo IS the completion
      _onComplete(1.0);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error ?? 'Failed to upload photo')),
      );
    }
  }

  void _inviteFriends() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _InviteFriendsSheet(challenge: widget.challenge),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(widget.challenge.category.colorValue);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF0F0F23),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: Colors.white, size: 18),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color.withOpacity(0.6),
                      color.withOpacity(0.2),
                      const Color(0xFF0F0F23),
                    ],
                  ),
                ),
                child: Center(
                  child: Hero(
                    tag: 'challenge_${widget.challenge.id}',
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Icon(
                        widget.challenge.icon,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    _getTitle(widget.challenge.id),
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Badges
                  Row(
                    children: [
                      _buildBadge(
                        widget.challenge.category.icon,
                        widget.challenge.category.displayName,
                        color,
                      ),
                      const SizedBox(width: 8),
                      _buildDifficultyBadge(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Description
                  Text(
                    _getDescription(widget.challenge.id),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Participants section
                  _buildParticipantsSection(color),
                  const SizedBox(height: 24),

                  // Join or Track section
                  if (!_isJoined)
                    _buildJoinSection(color)
                  else
                    _buildTrackingSection(),

                  const SizedBox(height: 24),

                  // Social reactions (if completed)
                  if (_isCompleted && widget.challenge.allowReactions)
                    SocialReactionsBar(
                      reactions: SocialReaction.availableReactions,
                      onReactionTap: (reaction) {
                        // TODO: Handle reaction
                      },
                    ),

                  const SizedBox(height: 32),

                  // Leaderboard preview
                  _buildLeaderboardPreview(color),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyBadge() {
    final difficulty = widget.challenge.difficulty;
    final info = _getDifficultyInfo(difficulty);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: info.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        info.label,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: info.color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildParticipantsSection(Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Stacked avatars
          SizedBox(
            width: 70,
            height: 36,
            child: Stack(
              children: List.generate(3, (i) {
                return Positioned(
                  left: i * 18.0,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color:
                          Colors.primaries[(i * 5) % Colors.primaries.length],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1A1A2E),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        ['L', 'S', 'A'][i],
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '12 friends participating',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '48 people worldwide',
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.white54),
                ),
              ],
            ),
          ),
          // Invite button
          GestureDetector(
            onTap: _inviteFriends,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.person_add, color: color, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinSection(Color color) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _joinChallenge,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.flag),
              const SizedBox(width: 8),
              Text(
                'Join Challenge',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Progress",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          TrackingWidgetFactory(
            challenge: widget.challenge,
            onComplete: _onComplete,
            onPhotoTaken: _onPhotoTaken,
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardPreview(Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.leaderboard, color: color, size: 22),
              const SizedBox(width: 8),
              Text(
                'Leaderboard',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                'View All',
                style: GoogleFonts.inter(fontSize: 13, color: color),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Top 3
          ...List.generate(3, (i) {
            final medals = ['🥇', '🥈', '🥉'];
            final names = ['Ahmed', 'Lena', 'Sarah'];
            final streaks = [21, 18, 15];

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(medals[i], style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color:
                          Colors.primaries[(i * 4) % Colors.primaries.length],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        names[i][0],
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      names[i],
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: Color(0xFFFF9800),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${streaks[i]} days',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _getTitle(String id) {
    return id
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '',
        )
        .join(' ');
  }

  String _getDescription(String id) {
    // In production, use localization
    final descriptions = {
      'water_warrior':
          'Drink 8 glasses of water daily to stay hydrated and healthy.',
      '10k_steps':
          'Walk 10,000 steps every day to improve your cardiovascular health.',
      'no_sugar': 'Avoid refined sugar and sweets for the entire day.',
      'five_prayers':
          'Pray all 5 obligatory prayers on time throughout the day.',
      'fajr_champion':
          'Wake up and pray Fajr before sunrise. Button locks at 6 AM!',
      'deep_work': 'Complete 2 hours of focused work without distractions.',
      'gratitude_journal': 'Write down 3 things you are thankful for today.',
    };
    return descriptions[id] ??
        'Complete this challenge to earn XP and improve yourself.';
  }

  ({Color color, String label}) _getDifficultyInfo(
    ChallengeDifficulty difficulty,
  ) {
    switch (difficulty) {
      case ChallengeDifficulty.easy:
        return (color: const Color(0xFF4CAF50), label: '🌱 Easy');
      case ChallengeDifficulty.medium:
        return (color: const Color(0xFFFF9800), label: '⚡ Medium');
      case ChallengeDifficulty.hard:
        return (color: const Color(0xFFE91E63), label: '🔥 Hard');
    }
  }
}

/// Bottom sheet for inviting friends
class _InviteFriendsSheet extends StatelessWidget {
  final Challenge challenge;

  const _InviteFriendsSheet({required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Invite Friends',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Challenge your friends to join you!',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.white54),
          ),
          const SizedBox(height: 24),
          // Share options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ShareOption(icon: Icons.link, label: 'Copy Link', onTap: () {}),
              _ShareOption(
                icon: Icons.message,
                label: 'WhatsApp',
                onTap: () {},
              ),
              _ShareOption(icon: Icons.share, label: 'Share', onTap: () {}),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
