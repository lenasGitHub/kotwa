import 'package:flutter/material.dart';

/// Challenge tracking types - how progress is recorded
enum TrackingType {
  /// Simple yes/no completion
  boolean,

  /// Count-based (e.g., 8 glasses of water)
  counter,

  /// Time-based (e.g., 30 min meditation)
  timer,

  /// Stopwatch-based tracking
  stopwatch,

  /// Checklist of items
  checklist,

  /// Text/journal entry
  text,

  /// Photo proof required
  camera,

  /// Location-based verification
  gps,

  /// Time-locked (must complete before deadline)
  timeLocked,

  /// Combined types
  multiStep,
}

/// Challenge categories
enum ChallengeCategory {
  health('Health & Fitness', 0xFF4CAF50, Icons.fitness_center),
  spiritual('Spiritual', 0xFF9C27B0, Icons.self_improvement),
  productivity('Productivity', 0xFF2196F3, Icons.trending_up),
  mental('Mental Wellness', 0xFF00BCD4, Icons.spa),
  finance('Finance', 0xFFFF9800, Icons.savings),
  social('Social', 0xFFE91E63, Icons.people);

  final String displayName;
  final int colorValue;
  final IconData icon;

  const ChallengeCategory(this.displayName, this.colorValue, this.icon);
}

/// Challenge difficulty levels
enum ChallengeDifficulty { easy, medium, hard }
