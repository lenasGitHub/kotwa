import 'package:flutter/material.dart';

enum ChallengeType {
  coop, // "Walk to Mecca" (Sum of all)
  threshold, // "Sugar Free" (Individual > 80%)
  survivor, // "Fajr Prayer" (Last man standing)
  relay, // "Quran" (Chained)
}

enum BiomeType {
  forest, // Health
  ocean, // Spirit
  desert, // Finance
  mountain, // Productivity
}

class UserStats {
  final String userId;
  final String displayName;
  final String avatarUrl;
  final int totalXp;
  final int currentStreak;
  final int currentLevel;

  UserStats({
    required this.userId,
    required this.displayName,
    required this.avatarUrl,
    required this.totalXp,
    required this.currentStreak,
    required this.currentLevel,
  });
}

class ParticipantProgress {
  final UserStats user;
  final double progress; // 0.0 to 1.0
  final int value; // Raw value (e.g. steps count)
  final bool isEliminated; // For Survivor mode

  ParticipantProgress({
    required this.user,
    required this.progress,
    required this.value,
    this.isEliminated = false,
  });
}

class GameChallenge {
  final String id;
  final String title;
  final String description;
  final ChallengeType type;
  final BiomeType biome;
  final DateTime startDate;
  final DateTime endDate;
  final List<ParticipantProgress> participants;

  // For Co-op: The total goal (e.g., 1,500,000 steps)
  final double targetGoal;

  GameChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.biome,
    required this.startDate,
    required this.endDate,
    required this.participants,
    required this.targetGoal,
  });

  // Helper to calculate total team progress
  double get teamProgress {
    if (type == ChallengeType.coop) {
      final totalValue = participants.fold<double>(
        0,
        (sum, p) => sum + p.value,
      );
      return (totalValue / targetGoal).clamp(0.0, 1.0);
    }
    // For others, we might return average progress
    return participants.fold<double>(0, (sum, p) => sum + p.progress) /
        participants.length;
  }
}
