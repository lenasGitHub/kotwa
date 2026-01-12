import '../domain/models/game_models.dart';

class MockGameRepository {
  static GameChallenge getMeccaChallenge() {
    return GameChallenge(
      id: 'mecca_walk_2024',
      title: 'The Walk to Mecca',
      description: 'A 1,500km journey with your best friends.',
      type: ChallengeType.coop,
      biome: BiomeType.desert,
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().add(const Duration(days: 25)),
      targetGoal: 1500000, // 1.5M steps total
      participants: [
        ParticipantProgress(
          user: UserStats(
            userId: 'u1',
            displayName: 'Lena',
            avatarUrl: 'https://i.pravatar.cc/150?img=68',
            totalXp: 1200,
            currentStreak: 5,
            currentLevel: 12,
          ),
          progress:
              0.65, // 65% of personal contribution? No, simplified for map
          value: 120000,
        ),
        ParticipantProgress(
          user: UserStats(
            userId: 'u2',
            displayName: 'Sarah',
            avatarUrl: 'https://i.pravatar.cc/150?img=1',
            totalXp: 900,
            currentStreak: 3,
            currentLevel: 10,
          ),
          progress: 0.45,
          value: 85000,
        ),
        ParticipantProgress(
          user: UserStats(
            userId: 'u3',
            displayName: 'Ahmed',
            avatarUrl: 'https://i.pravatar.cc/150?img=3',
            totalXp: 2100,
            currentStreak: 21,
            currentLevel: 25,
          ),
          progress: 0.80,
          value: 400000,
        ),
      ],
    );
  }
}
