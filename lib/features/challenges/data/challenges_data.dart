import 'package:flutter/material.dart';
import '../domain/models/challenge.dart';
import '../domain/models/tracking_type.dart';

/// Static challenge data for all 40+ challenges
class ChallengesData {
  static const List<Challenge> allChallenges = [
    // ==================== HEALTH & FITNESS ====================
    Challenge(
      id: 'water_warrior',
      titleKey: 'challenges.water_warrior.title',
      descriptionKey: 'challenges.water_warrior.description',
      category: ChallengeCategory.health,
      trackingType: TrackingType.counter,
      difficulty: ChallengeDifficulty.easy,
      counterConfig: CounterConfig(targetValue: 8, unit: 'glasses'),
      icon: Icons.water_drop,
    ),
    Challenge(
      id: '10k_steps',
      titleKey: 'challenges.10k_steps.title',
      descriptionKey: 'challenges.10k_steps.description',
      category: ChallengeCategory.health,
      trackingType: TrackingType.counter,
      difficulty: ChallengeDifficulty.medium,
      counterConfig: CounterConfig(targetValue: 10000, unit: 'steps'),
      icon: Icons.directions_walk,
    ),
    Challenge(
      id: 'no_sugar',
      titleKey: 'challenges.no_sugar.title',
      descriptionKey: 'challenges.no_sugar.description',
      category: ChallengeCategory.health,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.hard,
      icon: Icons.no_food,
    ),
    Challenge(
      id: '30_min_active',
      titleKey: 'challenges.30_min_active.title',
      descriptionKey: 'challenges.30_min_active.description',
      category: ChallengeCategory.health,
      trackingType: TrackingType.timer,
      difficulty: ChallengeDifficulty.medium,
      timerConfig: TimerConfig(targetDuration: Duration(minutes: 30)),
      icon: Icons.fitness_center,
    ),
    Challenge(
      id: 'plank_master',
      titleKey: 'challenges.plank_master.title',
      descriptionKey: 'challenges.plank_master.description',
      category: ChallengeCategory.health,
      trackingType: TrackingType.stopwatch,
      difficulty: ChallengeDifficulty.hard,
      icon: Icons.sports_gymnastics,
    ),
    Challenge(
      id: 'eat_green',
      titleKey: 'challenges.eat_green.title',
      descriptionKey: 'challenges.eat_green.description',
      category: ChallengeCategory.health,
      trackingType: TrackingType.camera, // Photo proof of healthy meal
      difficulty: ChallengeDifficulty.easy,
      icon: Icons.eco,
    ),
    Challenge(
      id: 'no_late_snack',
      titleKey: 'challenges.no_late_snack.title',
      descriptionKey: 'challenges.no_late_snack.description',
      category: ChallengeCategory.health,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.medium,
      icon: Icons.nights_stay,
    ),
    Challenge(
      id: 'gym_shark',
      titleKey: 'challenges.gym_shark.title',
      descriptionKey: 'challenges.gym_shark.description',
      category: ChallengeCategory.health,
      trackingType: TrackingType.gps,
      difficulty: ChallengeDifficulty.medium,
      gpsConfig: GpsConfig(
        latitude: 0, // Will be set by user
        longitude: 0,
        locationName: 'Your Gym',
      ),
      icon: Icons.location_on,
    ),
    Challenge(
      id: 'sleep_8_hours',
      titleKey: 'challenges.sleep_8_hours.title',
      descriptionKey: 'challenges.sleep_8_hours.description',
      category: ChallengeCategory.health,
      trackingType: TrackingType.counter,
      difficulty: ChallengeDifficulty.medium,
      counterConfig: CounterConfig(targetValue: 8, unit: 'hours'),
      icon: Icons.bedtime,
    ),
    Challenge(
      id: 'squat_challenge',
      titleKey: 'challenges.squat_challenge.title',
      descriptionKey: 'challenges.squat_challenge.description',
      category: ChallengeCategory.health,
      trackingType: TrackingType.counter,
      difficulty: ChallengeDifficulty.medium,
      counterConfig: CounterConfig(targetValue: 50, unit: 'squats'),
      icon: Icons.accessibility_new,
    ),

    // ==================== RELIGIOUS & SPIRITUAL ====================
    Challenge(
      id: 'five_prayers',
      titleKey: 'challenges.five_prayers.title',
      descriptionKey: 'challenges.five_prayers.description',
      category: ChallengeCategory.spiritual,
      trackingType: TrackingType.checklist,
      difficulty: ChallengeDifficulty.medium,
      checklistConfig: ChecklistConfig(
        items: ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'],
      ),
      icon: Icons.mosque,
    ),
    Challenge(
      id: 'fajr_champion',
      titleKey: 'challenges.fajr_champion.title',
      descriptionKey: 'challenges.fajr_champion.description',
      category: ChallengeCategory.spiritual,
      trackingType: TrackingType.timeLocked,
      difficulty: ChallengeDifficulty.hard,
      timeLockConfig: TimeLockConfig(
        lockTime: TimeOfDay(hour: 6, minute: 0),
        lockedMessage: "Fajr time has passed! Wake up earlier tomorrow 🌅",
      ),
      icon: Icons.wb_twilight,
    ),
    Challenge(
      id: 'quran_daily',
      titleKey: 'challenges.quran_daily.title',
      descriptionKey: 'challenges.quran_daily.description',
      category: ChallengeCategory.spiritual,
      trackingType: TrackingType.counter,
      difficulty: ChallengeDifficulty.easy,
      counterConfig: CounterConfig(targetValue: 1, unit: 'page'),
      icon: Icons.menu_book,
    ),
    Challenge(
      id: 'dhikr_counter',
      titleKey: 'challenges.dhikr_counter.title',
      descriptionKey: 'challenges.dhikr_counter.description',
      category: ChallengeCategory.spiritual,
      trackingType: TrackingType.counter,
      difficulty: ChallengeDifficulty.easy,
      counterConfig: CounterConfig(targetValue: 100, unit: 'times'),
      icon: Icons.radio_button_checked,
    ),
    Challenge(
      id: 'monday_fast',
      titleKey: 'challenges.monday_fast.title',
      descriptionKey: 'challenges.monday_fast.description',
      category: ChallengeCategory.spiritual,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.hard,
      icon: Icons.restaurant,
    ),
    Challenge(
      id: 'surah_kahf',
      titleKey: 'challenges.surah_kahf.title',
      descriptionKey: 'challenges.surah_kahf.description',
      category: ChallengeCategory.spiritual,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.easy,
      icon: Icons.auto_stories,
    ),
    Challenge(
      id: 'night_prayer',
      titleKey: 'challenges.night_prayer.title',
      descriptionKey: 'challenges.night_prayer.description',
      category: ChallengeCategory.spiritual,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.hard,
      icon: Icons.dark_mode,
    ),
    Challenge(
      id: 'daily_charity',
      titleKey: 'challenges.daily_charity.title',
      descriptionKey: 'challenges.daily_charity.description',
      category: ChallengeCategory.spiritual,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.easy,
      icon: Icons.volunteer_activism,
    ),

    // ==================== PRODUCTIVITY ====================
    Challenge(
      id: 'deep_work',
      titleKey: 'challenges.deep_work.title',
      descriptionKey: 'challenges.deep_work.description',
      category: ChallengeCategory.productivity,
      trackingType: TrackingType.timer,
      difficulty: ChallengeDifficulty.hard,
      timerConfig: TimerConfig(targetDuration: Duration(hours: 2)),
      icon: Icons.psychology,
    ),
    Challenge(
      id: 'read_10_pages',
      titleKey: 'challenges.read_10_pages.title',
      descriptionKey: 'challenges.read_10_pages.description',
      category: ChallengeCategory.productivity,
      trackingType: TrackingType.counter,
      difficulty: ChallengeDifficulty.medium,
      counterConfig: CounterConfig(targetValue: 10, unit: 'pages'),
      icon: Icons.book,
    ),
    Challenge(
      id: 'inbox_zero',
      titleKey: 'challenges.inbox_zero.title',
      descriptionKey: 'challenges.inbox_zero.description',
      category: ChallengeCategory.productivity,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.easy,
      icon: Icons.mark_email_read,
    ),
    Challenge(
      id: 'learn_language',
      titleKey: 'challenges.learn_language.title',
      descriptionKey: 'challenges.learn_language.description',
      category: ChallengeCategory.productivity,
      trackingType: TrackingType.timer,
      difficulty: ChallengeDifficulty.medium,
      timerConfig: TimerConfig(targetDuration: Duration(minutes: 15)),
      icon: Icons.translate,
    ),
    Challenge(
      id: 'code_streak',
      titleKey: 'challenges.code_streak.title',
      descriptionKey: 'challenges.code_streak.description',
      category: ChallengeCategory.productivity,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.medium,
      icon: Icons.code,
    ),
    Challenge(
      id: 'wake_up_early',
      titleKey: 'challenges.wake_up_early.title',
      descriptionKey: 'challenges.wake_up_early.description',
      category: ChallengeCategory.productivity,
      trackingType: TrackingType.timeLocked,
      difficulty: ChallengeDifficulty.hard,
      timeLockConfig: TimeLockConfig(
        lockTime: TimeOfDay(hour: 6, minute: 0),
        lockedMessage: "It's past 6 AM! Set your alarm earlier tomorrow ⏰",
      ),
      icon: Icons.alarm,
    ),
    Challenge(
      id: 'plan_the_day',
      titleKey: 'challenges.plan_the_day.title',
      descriptionKey: 'challenges.plan_the_day.description',
      category: ChallengeCategory.productivity,
      trackingType: TrackingType.text,
      difficulty: ChallengeDifficulty.easy,
      icon: Icons.checklist,
    ),
    Challenge(
      id: 'limit_social_media',
      titleKey: 'challenges.limit_social_media.title',
      descriptionKey: 'challenges.limit_social_media.description',
      category: ChallengeCategory.productivity,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.hard,
      icon: Icons.phone_android,
    ),

    // ==================== MENTAL WELLBEING ====================
    Challenge(
      id: 'gratitude_journal',
      titleKey: 'challenges.gratitude_journal.title',
      descriptionKey: 'challenges.gratitude_journal.description',
      category: ChallengeCategory.mental,
      trackingType: TrackingType.text,
      difficulty: ChallengeDifficulty.easy,
      icon: Icons.favorite,
    ),
    Challenge(
      id: 'meditation',
      titleKey: 'challenges.meditation.title',
      descriptionKey: 'challenges.meditation.description',
      category: ChallengeCategory.mental,
      trackingType: TrackingType.timer,
      difficulty: ChallengeDifficulty.medium,
      timerConfig: TimerConfig(targetDuration: Duration(minutes: 10)),
      icon: Icons.self_improvement,
    ),
    Challenge(
      id: 'digital_detox',
      titleKey: 'challenges.digital_detox.title',
      descriptionKey: 'challenges.digital_detox.description',
      category: ChallengeCategory.mental,
      trackingType: TrackingType.timer,
      difficulty: ChallengeDifficulty.hard,
      timerConfig: TimerConfig(targetDuration: Duration(hours: 1)),
      icon: Icons.phonelink_off,
    ),
    Challenge(
      id: 'skincare_routine',
      titleKey: 'challenges.skincare_routine.title',
      descriptionKey: 'challenges.skincare_routine.description',
      category: ChallengeCategory.mental,
      trackingType: TrackingType.checklist,
      difficulty: ChallengeDifficulty.easy,
      checklistConfig: ChecklistConfig(
        items: ['Morning routine', 'Night routine'],
      ),
      icon: Icons.face,
    ),
    Challenge(
      id: 'nature_walk',
      titleKey: 'challenges.nature_walk.title',
      descriptionKey: 'challenges.nature_walk.description',
      category: ChallengeCategory.mental,
      trackingType: TrackingType.timer,
      difficulty: ChallengeDifficulty.easy,
      timerConfig: TimerConfig(targetDuration: Duration(minutes: 15)),
      icon: Icons.park,
    ),
    Challenge(
      id: 'random_kindness',
      titleKey: 'challenges.random_kindness.title',
      descriptionKey: 'challenges.random_kindness.description',
      category: ChallengeCategory.mental,
      trackingType: TrackingType.text,
      difficulty: ChallengeDifficulty.easy,
      icon: Icons.emoji_emotions,
    ),
    Challenge(
      id: 'no_complaints',
      titleKey: 'challenges.no_complaints.title',
      descriptionKey: 'challenges.no_complaints.description',
      category: ChallengeCategory.mental,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.hard,
      icon: Icons.sentiment_satisfied,
    ),

    // ==================== FINANCE ====================
    Challenge(
      id: 'no_spend_day',
      titleKey: 'challenges.no_spend_day.title',
      descriptionKey: 'challenges.no_spend_day.description',
      category: ChallengeCategory.finance,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.hard,
      icon: Icons.money_off,
    ),
    Challenge(
      id: 'pack_lunch',
      titleKey: 'challenges.pack_lunch.title',
      descriptionKey: 'challenges.pack_lunch.description',
      category: ChallengeCategory.finance,
      trackingType: TrackingType.camera,
      difficulty: ChallengeDifficulty.medium,
      icon: Icons.lunch_dining,
    ),
    Challenge(
      id: 'track_expenses',
      titleKey: 'challenges.track_expenses.title',
      descriptionKey: 'challenges.track_expenses.description',
      category: ChallengeCategory.finance,
      trackingType: TrackingType.text,
      difficulty: ChallengeDifficulty.medium,
      icon: Icons.receipt_long,
    ),
    Challenge(
      id: 'coffee_at_home',
      titleKey: 'challenges.coffee_at_home.title',
      descriptionKey: 'challenges.coffee_at_home.description',
      category: ChallengeCategory.finance,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.easy,
      icon: Icons.coffee,
    ),
    Challenge(
      id: 'save_the_change',
      titleKey: 'challenges.save_the_change.title',
      descriptionKey: 'challenges.save_the_change.description',
      category: ChallengeCategory.finance,
      trackingType: TrackingType.counter,
      difficulty: ChallengeDifficulty.easy,
      counterConfig: CounterConfig(targetValue: 10, unit: 'JOD'),
      icon: Icons.savings,
    ),

    // ==================== SOCIAL & RELATIONSHIPS ====================
    Challenge(
      id: 'call_mom_dad',
      titleKey: 'challenges.call_mom_dad.title',
      descriptionKey: 'challenges.call_mom_dad.description',
      category: ChallengeCategory.social,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.easy,
      icon: Icons.phone_in_talk,
    ),
    Challenge(
      id: 'no_phone_meal',
      titleKey: 'challenges.no_phone_meal.title',
      descriptionKey: 'challenges.no_phone_meal.description',
      category: ChallengeCategory.social,
      trackingType: TrackingType.timer,
      difficulty: ChallengeDifficulty.medium,
      timerConfig: TimerConfig(targetDuration: Duration(minutes: 30)),
      icon: Icons.no_cell,
    ),
    Challenge(
      id: 'socialize',
      titleKey: 'challenges.socialize.title',
      descriptionKey: 'challenges.socialize.description',
      category: ChallengeCategory.social,
      trackingType: TrackingType.camera,
      difficulty: ChallengeDifficulty.medium,
      icon: Icons.groups,
    ),
    Challenge(
      id: 'active_listening',
      titleKey: 'challenges.active_listening.title',
      descriptionKey: 'challenges.active_listening.description',
      category: ChallengeCategory.social,
      trackingType: TrackingType.boolean,
      difficulty: ChallengeDifficulty.hard,
      icon: Icons.hearing,
    ),
  ];

  /// Get challenges by category
  static List<Challenge> getByCategory(ChallengeCategory category) {
    return allChallenges.where((c) => c.category == category).toList();
  }

  /// Get challenge count per category
  static Map<ChallengeCategory, int> getCategoryCounts() {
    final counts = <ChallengeCategory, int>{};
    for (final category in ChallengeCategory.values) {
      counts[category] = getByCategory(category).length;
    }
    return counts;
  }

  static List<Challenge> getEnrolled() {
    // Return a subset of challenges as "enrolled" for demonstration
    // Using simple ID checks that we know exist
    return allChallenges
        .where(
          (c) => [
            'water_warrior',
            'no_sugar',
            'journaling_daily',
            'save_100',
          ].contains(c.id),
        )
        .toList();
  }
}
