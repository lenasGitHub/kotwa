import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/challenge.dart';
import '../../domain/models/tracking_type.dart';

/// Card widget for displaying a challenge in a list
class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final VoidCallback onTap;
  final int? participantCount;
  final List<String>? participantAvatars;

  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.onTap,
    this.participantCount,
    this.participantAvatars,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(challenge.category.colorValue);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(challenge.icon, color: color, size: 28),
            ),
            const SizedBox(width: 14),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    _getTitle(challenge.id),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Tracking type & difficulty
                  Row(
                    children: [
                      _buildTrackingBadge(),
                      const SizedBox(width: 8),
                      _buildDifficultyBadge(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Participants or arrow
            if (participantCount != null && participantCount! > 0)
              _buildParticipants()
            else
              Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingBadge() {
    final trackingInfo = _getTrackingInfo(challenge.trackingType);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(trackingInfo.icon, size: 12, color: Colors.white54),
          const SizedBox(width: 4),
          Text(
            trackingInfo.label,
            style: GoogleFonts.inter(fontSize: 11, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyBadge() {
    final difficultyInfo = _getDifficultyInfo(challenge.difficulty);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: difficultyInfo.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        difficultyInfo.label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: difficultyInfo.color,
        ),
      ),
    );
  }

  Widget _buildParticipants() {
    return Row(
      children: [
        // Stacked avatars
        SizedBox(
          width: 40,
          height: 24,
          child: Stack(
            children: [
              for (int i = 0; i < 3; i++)
                Positioned(
                  left: i * 12.0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.primaries[i * 3],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1A1A2E),
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '+$participantCount',
          style: GoogleFonts.inter(fontSize: 12, color: Colors.white54),
        ),
      ],
    );
  }

  String _getTitle(String id) {
    // Convert challenge ID to display title
    // In production, this would use localization
    return id
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '',
        )
        .join(' ');
  }

  ({IconData icon, String label}) _getTrackingInfo(TrackingType type) {
    switch (type) {
      case TrackingType.boolean:
        return (icon: Icons.check_circle_outline, label: 'Yes/No');
      case TrackingType.counter:
        return (icon: Icons.add_circle_outline, label: 'Counter');
      case TrackingType.timer:
        return (icon: Icons.timer, label: 'Timer');
      case TrackingType.stopwatch:
        return (icon: Icons.timer_outlined, label: 'Stopwatch');
      case TrackingType.checklist:
        return (icon: Icons.checklist, label: 'Checklist');
      case TrackingType.text:
        return (icon: Icons.edit, label: 'Journal');
      case TrackingType.gps:
        return (icon: Icons.location_on, label: 'Location');
      case TrackingType.camera:
        return (icon: Icons.camera_alt, label: 'Photo');
      case TrackingType.timeLocked:
        return (icon: Icons.lock_clock, label: 'Time-locked');
      case TrackingType.multiStep:
        return (icon: Icons.checklist_rtl, label: 'Multi-step');
    }
  }

  ({Color color, String label}) _getDifficultyInfo(
    ChallengeDifficulty difficulty,
  ) {
    switch (difficulty) {
      case ChallengeDifficulty.easy:
        return (color: const Color(0xFF4CAF50), label: 'Easy');
      case ChallengeDifficulty.medium:
        return (color: const Color(0xFFFF9800), label: 'Medium');
      case ChallengeDifficulty.hard:
        return (color: const Color(0xFFE91E63), label: 'Hard');
    }
  }
}
