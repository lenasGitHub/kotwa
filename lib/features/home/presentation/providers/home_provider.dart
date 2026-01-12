import 'package:flutter/material.dart';
import '../widgets/organic_field_widget.dart';

class HomeProvider {
  // Singleton pattern for simplicity in this migration
  static final HomeProvider _instance = HomeProvider._internal();
  factory HomeProvider() => _instance;
  HomeProvider._internal();

  /// Generate initial dummy data
  List<FieldItem> generateFieldItems() {
    return [
      FieldItem(
        id: 0,
        crossAxisCellCount: 2,
        mainAxisCellCount: 4,
        title: 'Health & Fitness',
        subtitle: 'Daily Workout • Diet\nWater • 75% Done',
        icon: Icons.fitness_center,
        pins: [PinData(avatarIndex: 0), PinData(avatarIndex: 3)],
      ),
      FieldItem(
        id: 1,
        crossAxisCellCount: 1,
        mainAxisCellCount: 3,
        title: 'Religious & Spiritual',
        subtitle: 'Prayers • Reading\nMeditation • 5 Active',
        icon: Icons.self_improvement,
        pins: [
          PinData(avatarIndex: 1),
          PinData(avatarIndex: 4),
          PinData(avatarIndex: 5),
        ],
      ),
      FieldItem(
        id: 2,
        crossAxisCellCount: 1,
        mainAxisCellCount: 2,
        title: 'Productivity & Learning',
        subtitle: 'Reading • Coding\nFocus • 2h Today',
        icon: Icons.school,
        pins: [PinData(avatarIndex: 2)],
      ),
      FieldItem(
        id: 3,
        crossAxisCellCount: 2,
        mainAxisCellCount: 3,
        title: 'Mental Wellbeing',
        subtitle: 'Journaling • Yoga\nMindfulness • 10m',
        icon: Icons.spa,
      ),
      FieldItem(
        id: 4,
        crossAxisCellCount: 1,
        mainAxisCellCount: 4,
        title: 'Finance',
        subtitle: 'Budget • Savings\nInvestments • +12%',
        icon: Icons.savings,
      ),
      FieldItem(
        id: 5,
        crossAxisCellCount: 1,
        mainAxisCellCount: 2,
        title: 'Social & Relationships',
        subtitle: 'Family • Friends\nEvents • 3 Planned',
        icon: Icons.people,
      ),
      // ... Filling rest with generated data
      ...List.generate(24, (index) {
        final id = index + 6;
        return FieldItem(
          id: id,
          crossAxisCellCount: (index % 3 == 0) ? 2 : 1, // varied width
          mainAxisCellCount: 2 + (index % 3), // varied height 2-4
          title: 'Habit Group #$id',
          subtitle: 'General • Mixed\nStatus • Active',
          icon: index % 2 == 0
              ? Icons.check_circle_outline
              : Icons.star_outline,
        );
      }),
    ];
  }
}
