import 'package:flutter/material.dart';
import 'tracking_type.dart';

/// Represents a social reaction on a challenge completion
class SocialReaction {
  final String odeName; // 'like', 'love', 'fire', 'clap', '100'
  final String emoji;
  final int count;
  final List<String> userIds;

  const SocialReaction({
    required this.odeName,
    required this.emoji,
    this.count = 0,
    this.userIds = const [],
  });

  static const List<SocialReaction> availableReactions = [
    SocialReaction(odeName: 'like', emoji: '👍'),
    SocialReaction(odeName: 'love', emoji: '❤️'),
    SocialReaction(odeName: 'fire', emoji: '🔥'),
    SocialReaction(odeName: 'clap', emoji: '👏'),
    SocialReaction(odeName: 'hundred', emoji: '💯'),
  ];
}

/// Configuration for time-locked challenges
class TimeLockConfig {
  final TimeOfDay lockTime;
  final String lockedMessage;

  const TimeLockConfig({
    required this.lockTime,
    this.lockedMessage = "Too late! Try again tomorrow 😅",
  });

  bool get isLocked {
    final now = TimeOfDay.now();
    // Simple comparison: if current time >= lock time, it's locked
    return (now.hour > lockTime.hour) ||
        (now.hour == lockTime.hour && now.minute >= lockTime.minute);
  }
}

/// Configuration for checklist-type challenges
class ChecklistConfig {
  final List<String> items;

  const ChecklistConfig({required this.items});
}

/// Configuration for counter-type challenges
class CounterConfig {
  final int targetValue;
  final String unit; // "glasses", "squats", "pages", etc.

  const CounterConfig({required this.targetValue, this.unit = ''});
}

/// Configuration for timer-type challenges
class TimerConfig {
  final Duration targetDuration;

  const TimerConfig({required this.targetDuration});
}

/// Configuration for GPS-type challenges
class GpsConfig {
  final double latitude;
  final double longitude;
  final double radiusMeters;
  final String locationName;

  const GpsConfig({
    required this.latitude,
    required this.longitude,
    this.radiusMeters = 100,
    this.locationName = 'Location',
  });
}

/// Main Challenge model
class Challenge {
  final String id;
  final String titleKey; // Localization key
  final String descriptionKey;
  final ChallengeCategory category;
  final TrackingType trackingType;
  final ChallengeDifficulty difficulty;

  // Optional tracking configs (based on type)
  final TimeLockConfig? timeLockConfig;
  final ChecklistConfig? checklistConfig;
  final CounterConfig? counterConfig;
  final TimerConfig? timerConfig;
  final GpsConfig? gpsConfig;

  // Social features (always available)
  final bool allowCameraProof; // All types can optionally have camera
  final bool allowReactions; // Likes, love, etc.

  // Visual
  final IconData icon;

  const Challenge({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.category,
    required this.trackingType,
    required this.difficulty,
    this.timeLockConfig,
    this.checklistConfig,
    this.counterConfig,
    this.timerConfig,
    this.gpsConfig,
    this.allowCameraProof = true, // Default: all challenges can have photos
    this.allowReactions = true, // Default: all challenges can have reactions
    this.icon = Icons.check_circle_outline,
  });
}

/// User's progress on a specific challenge
class ChallengeProgress {
  final String odeName;
  final String odeName2;
  final DateTime date;

  // Tracking data (varies by type)
  final bool? boolValue;
  final int? counterValue;
  final Duration? timerValue;
  final List<bool>? checklistValues;
  final String? textValue;
  final String? photoUrl;

  // Social
  final List<SocialReaction> reactions;

  // Gamification
  final int xpEarned;
  final bool isStreakDay;

  ChallengeProgress({
    required this.odeName,
    required this.odeName2,
    required this.date,
    this.boolValue,
    this.counterValue,
    this.timerValue,
    this.checklistValues,
    this.textValue,
    this.photoUrl,
    this.reactions = const [],
    this.xpEarned = 0,
    this.isStreakDay = false,
  });

  bool get hasPhotoProof => photoUrl != null && photoUrl!.isNotEmpty;
}
