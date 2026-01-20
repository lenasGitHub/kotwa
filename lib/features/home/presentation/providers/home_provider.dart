import 'package:flutter/material.dart';
import '../widgets/organic_field_widget.dart';
import '../../../challenges/domain/models/tracking_type.dart';
import '../../../../core/services/api_service.dart';

class HomeProvider extends ChangeNotifier {
  static final HomeProvider _instance = HomeProvider._internal();
  factory HomeProvider() => _instance;
  HomeProvider._internal();

  List<FieldItem> _fieldItems = [];
  List<FieldItem> get fieldItems => _fieldItems;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Initialize with static data + fetch from API
  Future<void> initialize() async {
    // Start with static category data
    _fieldItems = _generateCategoryFields();
    notifyListeners();

    // Then try to load live participant data from API
    await _loadParticipantsFromApi();
  }

  /// Generate field items based on challenge categories
  List<FieldItem> _generateCategoryFields() {
    return [
      FieldItem(
        id: ChallengeCategory.health.index,
        category: ChallengeCategory.health,
        crossAxisCellCount: 2,
        mainAxisCellCount: 4,
        title: ChallengeCategory.health.displayName,
        subtitle: 'Daily Workout • Diet\nWater • 10 Challenges',
        icon: Icons.fitness_center,
        color: Color(ChallengeCategory.health.colorValue),
        pins: [PinData(avatarIndex: 0), PinData(avatarIndex: 3)],
      ),
      FieldItem(
        id: ChallengeCategory.spiritual.index,
        category: ChallengeCategory.spiritual,
        crossAxisCellCount: 1,
        mainAxisCellCount: 3,
        title: ChallengeCategory.spiritual.displayName,
        subtitle: 'Prayers • Reading\nMeditation • 8 Challenges',
        icon: Icons.self_improvement,
        color: Color(ChallengeCategory.spiritual.colorValue),
        pins: [
          PinData(avatarIndex: 1),
          PinData(avatarIndex: 4),
          PinData(avatarIndex: 5),
        ],
      ),
      FieldItem(
        id: ChallengeCategory.productivity.index,
        category: ChallengeCategory.productivity,
        crossAxisCellCount: 1,
        mainAxisCellCount: 2,
        title: ChallengeCategory.productivity.displayName,
        subtitle: 'Reading • Focus\nDeep Work • 8 Challenges',
        icon: Icons.trending_up,
        color: Color(ChallengeCategory.productivity.colorValue),
        pins: [PinData(avatarIndex: 2)],
      ),
      // Special "My Land" Field (Centered roughly)
      FieldItem(
        id: 999, // Special ID
        crossAxisCellCount: 3,
        mainAxisCellCount: 3,
        title: 'My Land',
        subtitle: 'My Enrolled Challenges',
        icon: Icons.landscape,
        color: const Color(0xFFFFD700), // Gold
        pins: [],
      ),
      FieldItem(
        id: ChallengeCategory.mental.index,
        category: ChallengeCategory.mental,
        crossAxisCellCount: 2,
        mainAxisCellCount: 3,
        title: ChallengeCategory.mental.displayName,
        subtitle: 'Journaling • Yoga\nMindfulness • 7 Challenges',
        icon: Icons.spa,
        color: Color(ChallengeCategory.mental.colorValue),
      ),
      FieldItem(
        id: ChallengeCategory.finance.index,
        category: ChallengeCategory.finance,
        crossAxisCellCount: 1,
        mainAxisCellCount: 4,
        title: ChallengeCategory.finance.displayName,
        subtitle: 'Budget • Savings\nTracking • 5 Challenges',
        icon: Icons.savings,
        color: Color(ChallengeCategory.finance.colorValue),
      ),
      FieldItem(
        id: ChallengeCategory.social.index,
        category: ChallengeCategory.social,
        crossAxisCellCount: 1,
        mainAxisCellCount: 2,
        title: ChallengeCategory.social.displayName,
        subtitle: 'Family • Friends\nEvents • 4 Challenges',
        icon: Icons.people,
        color: Color(ChallengeCategory.social.colorValue),
      ),
    ];
  }

  /// Load participant data from API and update fields
  Future<void> _loadParticipantsFromApi() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.getCategorySummaries();

      if (response.isSuccess && response.data != null) {
        for (final summary in response.data!) {
          // Find matching field and update it
          final index = _fieldItems.indexWhere(
            (f) => f.category?.name.toUpperCase() == summary.category,
          );

          if (index != -1) {
            final field = _fieldItems[index];
            _fieldItems[index] = FieldItem(
              id: field.id,
              category: field.category,
              crossAxisCellCount: field.crossAxisCellCount,
              mainAxisCellCount: field.mainAxisCellCount,
              title: field.title,
              subtitle: _buildSubtitle(field.category!, summary),
              icon: field.icon,
              color: field.color,
              pins: _buildPins(summary.activeParticipants),
              participantCount: summary.totalParticipants,
            );
          }
        }
      }
    } catch (e) {
      debugPrint('Error loading participants: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _buildSubtitle(
    ChallengeCategory category,
    CategorySummaryDto summary,
  ) {
    final subtitles = {
      ChallengeCategory.health: 'Fitness • Nutrition',
      ChallengeCategory.spiritual: 'Prayers • Reading',
      ChallengeCategory.productivity: 'Focus • Learning',
      ChallengeCategory.mental: 'Mindfulness • Self-care',
      ChallengeCategory.finance: 'Budget • Savings',
      ChallengeCategory.social: 'Family • Friends',
    };

    final base = subtitles[category] ?? 'Habits';
    final active = summary.totalParticipants > 0
        ? '${summary.totalParticipants} Active'
        : '${summary.challengeCount} Challenges';

    return '$base\n$active';
  }

  List<PinData> _buildPins(List<ParticipantDto> participants) {
    return participants.take(5).map((p) {
      return PinData(odeName: p.id, avatarUrl: p.avatarUrl, name: p.name);
    }).toList();
  }

  /// Refresh data from API
  Future<void> refresh() async {
    await _loadParticipantsFromApi();
  }

  /// Legacy method for backwards compatibility
  List<FieldItem> generateFieldItems() {
    if (_fieldItems.isEmpty) {
      _fieldItems = _generateCategoryFields();
    }
    return _fieldItems;
  }
}
