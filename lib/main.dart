import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_colors.dart';
import 'core/storage/storage_manager.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';

/// Main entry point - Initialize storage before running app
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Initialize StorageManager - CRITICAL for fixing MissingPluginException
  await StorageManager.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(StorageManager.getLanguage()),
      child: const HabitChallengeApp(),
    ),
  );
}

class HabitChallengeApp extends StatelessWidget {
  const HabitChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if language is already selected
    final savedLanguage = StorageManager.getLanguage();
    final isRTL = StorageManager.getIsRTL();
    // final hasLanguage = StorageManager.containsKey('language');

    return MaterialApp(
      title: 'تحدي العادات',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        textTheme: GoogleFonts.cairoTextTheme(),
        useMaterial3: true,
      ),
      // Navigate directly to HomeScreen
      home: HomeScreen(language: savedLanguage, isRTL: isRTL),
      //  home: hasLanguage
      // ? WelcomeScreen(language: savedLanguage, isRTL: isRTL)
      // : const LanguageSelectionScreen(),
    );
  }
}
