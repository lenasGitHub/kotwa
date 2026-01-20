import 'dart:convert';
import 'package:http/http.dart' as http;

/// API Service for communicating with the Steps backend
class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  static String? _authToken;

  /// Set the auth token for authenticated requests
  static void setAuthToken(String token) {
    _authToken = token;
  }

  /// Get headers with optional auth
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_authToken != null) 'Authorization': 'Bearer $_authToken',
  };

  // ==================== CHALLENGES ====================

  /// Get all challenges (optionally filtered by category)
  static Future<ApiResponse<List<ChallengeDto>>> getChallenges({
    String? category,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/challenges').replace(
        queryParameters: category != null ? {'category': category} : null,
      );

      final response = await http.get(uri, headers: _headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final challenges = (data['data'] as List)
            .map((c) => ChallengeDto.fromJson(c))
            .toList();
        return ApiResponse.success(challenges);
      } else {
        return ApiResponse.error('Failed to load challenges');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  /// Get challenge details with participants
  static Future<ApiResponse<ChallengeDetailDto>> getChallengeDetail(
    String challengeId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/challenges/$challengeId'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse.success(ChallengeDetailDto.fromJson(data['data']));
      } else {
        return ApiResponse.error('Failed to load challenge');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  /// Get challenge leaderboard
  static Future<ApiResponse<List<LeaderboardEntryDto>>> getLeaderboard(
    String challengeId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/challenges/$challengeId/leaderboard'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final entries = (data['data'] as List)
            .map((e) => LeaderboardEntryDto.fromJson(e))
            .toList();
        return ApiResponse.success(entries);
      } else {
        return ApiResponse.error('Failed to load leaderboard');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  /// Join a challenge
  static Future<ApiResponse<bool>> joinChallenge(String challengeId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/challenges/$challengeId/join'),
        headers: _headers,
      );

      return response.statusCode == 201
          ? ApiResponse.success(true)
          : ApiResponse.error('Failed to join challenge');
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  /// Log progress for a challenge
  static Future<ApiResponse<ProgressResponseDto>> logProgress({
    required String challengeId,
    required double value,
    bool isSuccess = true,
    String? note,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/progress'),
        headers: _headers,
        body: jsonEncode({
          'challengeId': challengeId,
          'value': value,
          'isSuccess': isSuccess,
          'note': note,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse.success(ProgressResponseDto.fromJson(data['data']));
      } else {
        return ApiResponse.error('Failed to log progress');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }

  /// Upload photo evidence
  static Future<ApiResponse<String>> uploadPhoto(
    String challengeId,
    String filePath,
  ) async {
    // TODO: Implement real backend upload
    // For now, return a mock success
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.success('https://example.com/mock_photo.jpg');
  }

  // ==================== CATEGORIES SUMMARY ====================

  /// Get category summary with participant counts (for home screen)
  static Future<ApiResponse<List<CategorySummaryDto>>>
  getCategorySummaries() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/challenges'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final challenges = data['data'] as List;

        // Group by category and count participants
        final Map<String, CategorySummaryDto> summaries = {};

        for (final c in challenges) {
          final category = c['category'] as String;
          final participants = (c['participants'] as List?) ?? [];

          if (!summaries.containsKey(category)) {
            summaries[category] = CategorySummaryDto(
              category: category,
              challengeCount: 0,
              activeParticipants: [],
              totalParticipants: 0,
            );
          }

          final current = summaries[category]!;
          summaries[category] = CategorySummaryDto(
            category: category,
            challengeCount: current.challengeCount + 1,
            activeParticipants: [
              ...current.activeParticipants,
              ...participants
                  .take(3)
                  .map((p) => ParticipantDto.fromJson(p['user'])),
            ].take(5).toList(),
            totalParticipants: current.totalParticipants + participants.length,
          );
        }

        return ApiResponse.success(summaries.values.toList());
      } else {
        return ApiResponse.error('Failed to load categories');
      }
    } catch (e) {
      return ApiResponse.error('Network error: $e');
    }
  }
}

// ==================== DTOs ====================

class ApiResponse<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  ApiResponse.success(this.data) : error = null, isSuccess = true;
  ApiResponse.error(this.error) : data = null, isSuccess = false;
}

class ChallengeDto {
  final String id;
  final String title;
  final String type;
  final String category;
  final int participantCount;
  final List<ParticipantDto> participants;

  ChallengeDto({
    required this.id,
    required this.title,
    required this.type,
    required this.category,
    required this.participantCount,
    required this.participants,
  });

  factory ChallengeDto.fromJson(Map<String, dynamic> json) {
    return ChallengeDto(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      category: json['category'],
      participantCount: json['_count']?['participants'] ?? 0,
      participants: ((json['participants'] as List?) ?? [])
          .map((p) => ParticipantDto.fromJson(p['user']))
          .toList(),
    );
  }
}

class ChallengeDetailDto {
  final String id;
  final String title;
  final String description;
  final String type;
  final String category;
  final double targetGoal;
  final double teamProgress;
  final List<ParticipantDto> participants;

  ChallengeDetailDto({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.targetGoal,
    required this.teamProgress,
    required this.participants,
  });

  factory ChallengeDetailDto.fromJson(Map<String, dynamic> json) {
    return ChallengeDetailDto(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      type: json['type'],
      category: json['category'],
      targetGoal: (json['targetGoal'] as num).toDouble(),
      teamProgress: (json['teamProgress'] as num?)?.toDouble() ?? 0,
      participants: ((json['participants'] as List?) ?? [])
          .map((p) => ParticipantDto.fromJson(p['user']))
          .toList(),
    );
  }
}

class ParticipantDto {
  final String id;
  final String name;
  final String? avatarUrl;

  ParticipantDto({required this.id, required this.name, this.avatarUrl});

  factory ParticipantDto.fromJson(Map<String, dynamic> json) {
    return ParticipantDto(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      avatarUrl: json['avatarUrl'],
    );
  }
}

class LeaderboardEntryDto {
  final int rank;
  final String odeName;
  final String name;
  final String? avatarUrl;
  final double value;
  final int level;

  LeaderboardEntryDto({
    required this.rank,
    required this.odeName,
    required this.name,
    this.avatarUrl,
    required this.value,
    required this.level,
  });

  factory LeaderboardEntryDto.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntryDto(
      rank: json['rank'] ?? 0,
      odeName: json['userId'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatarUrl'],
      value: (json['value'] as num?)?.toDouble() ?? 0,
      level: json['level'] ?? 1,
    );
  }
}

class ProgressResponseDto {
  final double totalValue;
  final int xpGained;

  ProgressResponseDto({required this.totalValue, required this.xpGained});

  factory ProgressResponseDto.fromJson(Map<String, dynamic> json) {
    return ProgressResponseDto(
      totalValue: (json['totalValue'] as num?)?.toDouble() ?? 0,
      xpGained: json['xpGained'] ?? 0,
    );
  }
}

class CategorySummaryDto {
  final String category;
  final int challengeCount;
  final List<ParticipantDto> activeParticipants;
  final int totalParticipants;

  CategorySummaryDto({
    required this.category,
    required this.challengeCount,
    required this.activeParticipants,
    required this.totalParticipants,
  });
}
