import '../storage/storage_manager.dart';

/// Represents the current authentication state of the user
enum AppAuthState {
  /// First time launching the app - needs full onboarding
  newUser,

  /// User started onboarding but didn't complete it
  returningIncomplete,

  /// User has completed onboarding - go directly to home
  authenticated,
}

/// Manages authentication state and determines app navigation flow
class AuthStateManager {
  /// Determines the current auth state based on stored preferences
  static AppAuthState getAuthState() {
    // Check if this is the first launch
    if (StorageManager.isFirstLaunch()) {
      return AppAuthState.newUser;
    }

    // Check if onboarding is completed
    if (!StorageManager.isOnboardingCompleted()) {
      return AppAuthState.returningIncomplete;
    }

    // User has completed everything
    return AppAuthState.authenticated;
  }

  /// Mark that the user has started the app (no longer first launch)
  static Future<void> markAppLaunched() async {
    await StorageManager.setFirstLaunchComplete();
  }

  /// Mark that onboarding is complete
  static Future<void> markOnboardingComplete() async {
    await StorageManager.setOnboardingCompleted(true);
  }

  /// Reset all auth state (for testing or logout)
  static Future<void> resetAuthState() async {
    await StorageManager.clearAll();
  }

  /// Check if user has selected a language
  static bool hasLanguageSelected() {
    return StorageManager.containsKey('language');
  }

  /// Get saved language preference
  static String getSavedLanguage() {
    return StorageManager.getLanguage();
  }

  /// Get saved RTL preference
  static bool getSavedIsRTL() {
    return StorageManager.getIsRTL();
  }
}
