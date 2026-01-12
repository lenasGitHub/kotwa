import 'package:shared_preferences/shared_preferences.dart';

/// Centralized storage manager for all app preferences
/// This class handles all local storage operations using SharedPreferences
class StorageManager {
  static SharedPreferences? _prefs;

  // Storage Keys - All storage keys are defined here for easy management
  static const String _keyLanguage = 'language';
  static const String _keyIsRTL = 'isRTL';
  static const String _keyIsFirstLaunch = 'isFirstLaunch';
  static const String _keyOnboardingCompleted = 'onboardingCompleted';
  static const String _keyUserName = 'userName';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyMotivationSource = 'motivationSource';
  static const String _keyCommitmentFactor = 'commitmentFactor';
  static const String _keyWantsFriend = 'wantsFriend';
  static const String _keyFriendInfo = 'friendInfo';
  static const String _keySelectedMicroHabits = 'selectedMicroHabits';
  // Persona keys
  static const String _keyPrimaryGoal = 'primaryGoal';
  static const String _keyPlayStyle = 'playStyle';

  /// Initialize SharedPreferences instance
  /// This MUST be called before using any storage methods
  /// Typically called in main() before runApp()
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get the SharedPreferences instance
  /// Throws an error if not initialized
  static SharedPreferences get instance {
    if (_prefs == null) {
      throw Exception(
        'StorageManager not initialized. Call StorageManager.init() first.',
      );
    }
    return _prefs!;
  }

  // ==================== Language Settings ====================

  /// Save the selected language
  static Future<bool> setLanguage(String language) async {
    return await instance.setString(_keyLanguage, language);
  }

  /// Get the saved language (default: 'en')
  static String getLanguage() {
    return instance.getString(_keyLanguage) ?? 'en';
  }

  /// Save RTL direction preference
  static Future<bool> setIsRTL(bool isRTL) async {
    return await instance.setBool(_keyIsRTL, isRTL);
  }

  /// Get RTL direction preference (default: false)
  static bool getIsRTL() {
    return instance.getBool(_keyIsRTL) ?? false;
  }

  /// Save both language and RTL preference together
  static Future<void> setLanguagePreferences({
    required String language,
    required bool isRTL,
  }) async {
    await setLanguage(language);
    await setIsRTL(isRTL);
  }

  // ==================== App State ====================

  /// Check if this is the first app launch
  static bool isFirstLaunch() {
    return instance.getBool(_keyIsFirstLaunch) ?? true;
  }

  /// Mark that the app has been launched
  static Future<bool> setFirstLaunchComplete() async {
    return await instance.setBool(_keyIsFirstLaunch, false);
  }

  /// Check if onboarding is completed
  static bool isOnboardingCompleted() {
    return instance.getBool(_keyOnboardingCompleted) ?? false;
  }

  /// Mark onboarding as completed
  static Future<bool> setOnboardingCompleted(bool completed) async {
    return await instance.setBool(_keyOnboardingCompleted, completed);
  }

  // ==================== User Information ====================

  /// Save user name
  static Future<bool> setUserName(String name) async {
    return await instance.setString(_keyUserName, name);
  }

  /// Get user name
  static String? getUserName() {
    return instance.getString(_keyUserName);
  }

  /// Save user email
  static Future<bool> setUserEmail(String email) async {
    return await instance.setString(_keyUserEmail, email);
  }

  /// Get user email
  static String? getUserEmail() {
    return instance.getString(_keyUserEmail);
  }

  // ==================== Quiz/Onboarding Data ====================

  /// Save motivation source
  static Future<bool> setMotivationSource(String source) async {
    return await instance.setString(_keyMotivationSource, source);
  }

  /// Get motivation source
  static String? getMotivationSource() {
    return instance.getString(_keyMotivationSource);
  }

  /// Save commitment factor
  static Future<bool> setCommitmentFactor(String factor) async {
    return await instance.setString(_keyCommitmentFactor, factor);
  }

  /// Get commitment factor
  static String? getCommitmentFactor() {
    return instance.getString(_keyCommitmentFactor);
  }

  /// Save wants friend preference
  static Future<bool> setWantsFriend(bool wants) async {
    return await instance.setBool(_keyWantsFriend, wants);
  }

  /// Get wants friend preference
  static bool? getWantsFriend() {
    return instance.getBool(_keyWantsFriend);
  }

  /// Save friend info
  static Future<bool> setFriendInfo(String info) async {
    return await instance.setString(_keyFriendInfo, info);
  }

  /// Get friend info
  static String? getFriendInfo() {
    return instance.getString(_keyFriendInfo);
  }

  /// Save selected micro habits as a list
  static Future<bool> setSelectedMicroHabits(List<String> habits) async {
    return await instance.setStringList(_keySelectedMicroHabits, habits);
  }

  /// Get selected micro habits
  static List<String>? getSelectedMicroHabits() {
    return instance.getStringList(_keySelectedMicroHabits);
  }

  // ==================== Persona Data ====================

  /// Save user persona data (from onboarding)
  static Future<void> setUserPersona({
    required String name,
    required String primaryGoal,
    required String motivation,
    required String playStyle,
  }) async {
    await setUserName(name);
    await instance.setString(_keyPrimaryGoal, primaryGoal);
    await setMotivationSource(motivation);
    await instance.setString(_keyPlayStyle, playStyle);
  }

  /// Get primary goal
  static String? getPrimaryGoal() {
    return instance.getString(_keyPrimaryGoal);
  }

  /// Get play style
  static String? getPlayStyle() {
    return instance.getString(_keyPlayStyle);
  }

  /// Alias for setOnboardingCompleted for consistency
  static Future<bool> setOnboardingComplete(bool complete) async {
    return await setOnboardingCompleted(complete);
  }

  // ==================== Utility Methods ====================

  /// Clear all stored data
  static Future<bool> clearAll() async {
    return await instance.clear();
  }

  /// Remove a specific key
  static Future<bool> remove(String key) async {
    return await instance.remove(key);
  }

  /// Check if a key exists
  static bool containsKey(String key) {
    return instance.containsKey(key);
  }

  /// Get all keys
  static Set<String> getAllKeys() {
    return instance.getKeys();
  }

  /// Print all stored data (for debugging)
  static void printAllData() {
    final keys = getAllKeys();
    print('=== StorageManager Data ===');
    for (var key in keys) {
      final value = instance.get(key);
      print('$key: $value');
    }
    print('===========================');
  }
}
