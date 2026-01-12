import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker_challenge/core/constants/app_colors.dart';
import 'package:habit_tracker_challenge/core/storage/storage_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'welcome_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  Future<void> _selectLanguage(String language, bool isRTL) async {
    // Update EasyLocalization locale
    await context.setLocale(Locale(language));

    // Use StorageManager to save language preferences
    await StorageManager.setLanguagePreferences(
      language: language,
      isRTL: isRTL,
    );

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(language: language, isRTL: isRTL),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // English button
              _buildLanguageOption(
                text: 'English',
                icon: Icons.language,
                onTap: () => _selectLanguage('en', false),
              ),
              const SizedBox(width: 40),
              // Arabic button
              _buildLanguageOption(
                text: 'عربي',
                icon: Icons.translate,
                onTap: () => _selectLanguage('ar', true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              text,
              style: GoogleFonts.cairo(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
