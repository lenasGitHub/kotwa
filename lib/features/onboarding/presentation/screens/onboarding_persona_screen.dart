import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:habit_tracker_challenge/core/storage/storage_manager.dart';
import 'package:habit_tracker_challenge/features/home/presentation/screens/home_screen.dart';

/// Short persona-based registration that doubles as onboarding
/// 4 Questions to understand user goals and preferences
class OnboardingPersonaScreen extends StatefulWidget {
  final String language;
  final bool isRTL;

  const OnboardingPersonaScreen({
    super.key,
    required this.language,
    required this.isRTL,
  });

  @override
  State<OnboardingPersonaScreen> createState() =>
      _OnboardingPersonaScreenState();
}

class _OnboardingPersonaScreenState extends State<OnboardingPersonaScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // User persona data
  String _name = '';
  String? _primaryGoal; // health, spiritual, productivity, finance, social
  String? _motivation; // self, family, community
  String? _playStyle; // solo, team, competitive

  final List<_OnboardingStep> _steps = [];

  @override
  void initState() {
    super.initState();
    _initSteps();
  }

  void _initSteps() {
    _steps.addAll([
      // Step 1: Name (Quick)
      _OnboardingStep(
        question: 'onboarding.persona.name_question',
        subtitle: 'onboarding.persona.name_subtitle',
        icon: Icons.person_outline,
        type: _StepType.textInput,
      ),
      // Step 2: Primary Goal (What do you want to improve?)
      _OnboardingStep(
        question: 'onboarding.persona.goal_question',
        subtitle: 'onboarding.persona.goal_subtitle',
        icon: Icons.flag_outlined,
        type: _StepType.singleChoice,
        options: [
          _Option(
            'health',
            'onboarding.persona.goal_health',
            Icons.favorite_border,
            const Color(0xFF4CAF50),
          ),
          _Option(
            'spiritual',
            'onboarding.persona.goal_spiritual',
            Icons.auto_awesome,
            const Color(0xFF9C27B0),
          ),
          _Option(
            'productivity',
            'onboarding.persona.goal_productivity',
            Icons.trending_up,
            const Color(0xFF2196F3),
          ),
          _Option(
            'finance',
            'onboarding.persona.goal_finance',
            Icons.savings_outlined,
            const Color(0xFFFF9800),
          ),
          _Option(
            'social',
            'onboarding.persona.goal_social',
            Icons.people_outline,
            const Color(0xFFE91E63),
          ),
        ],
      ),
      // Step 3: Motivation (Why do you want to change?)
      _OnboardingStep(
        question: 'onboarding.persona.motivation_question',
        subtitle: 'onboarding.persona.motivation_subtitle',
        icon: Icons.psychology_outlined,
        type: _StepType.singleChoice,
        options: [
          _Option(
            'self',
            'onboarding.persona.motivation_self',
            Icons.self_improvement,
            const Color(0xFF00BCD4),
          ),
          _Option(
            'family',
            'onboarding.persona.motivation_family',
            Icons.family_restroom,
            const Color(0xFFFF5722),
          ),
          _Option(
            'community',
            'onboarding.persona.motivation_community',
            Icons.groups,
            const Color(0xFF673AB7),
          ),
        ],
      ),
      // Step 4: Play Style (How do you like to play?)
      _OnboardingStep(
        question: 'onboarding.persona.style_question',
        subtitle: 'onboarding.persona.style_subtitle',
        icon: Icons.sports_esports_outlined,
        type: _StepType.singleChoice,
        options: [
          _Option(
            'solo',
            'onboarding.persona.style_solo',
            Icons.person,
            const Color(0xFF607D8B),
          ),
          _Option(
            'team',
            'onboarding.persona.style_team',
            Icons.group_work,
            const Color(0xFF4CAF50),
          ),
          _Option(
            'competitive',
            'onboarding.persona.style_competitive',
            Icons.emoji_events,
            const Color(0xFFFFD700),
          ),
        ],
      ),
    ]);
  }

  void _nextPage() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    // Save persona data
    await StorageManager.setUserPersona(
      name: _name,
      primaryGoal: _primaryGoal ?? 'health',
      motivation: _motivation ?? 'self',
      playStyle: _playStyle ?? 'solo',
    );

    // Mark onboarding complete
    await StorageManager.setOnboardingComplete(true);

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            HomeScreen(language: widget.language, isRTL: widget.isRTL),
      ),
    );
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return _name.trim().isNotEmpty;
      case 1:
        return _primaryGoal != null;
      case 2:
        return _motivation != null;
      case 3:
        return _playStyle != null;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Progress indicator
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: List.generate(
                    _steps.length,
                    (index) => Expanded(
                      child: Container(
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: index <= _currentPage
                              ? const Color(0xFF26F05F)
                              : Colors.white24,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Page content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (page) => setState(() => _currentPage = page),
                  itemCount: _steps.length,
                  itemBuilder: (context, index) {
                    return _buildStepPage(_steps[index], index);
                  },
                ),
              ),

              // Continue button
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _canProceed() ? _nextPage : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF26F05F),
                      foregroundColor: Colors.black,
                      disabledBackgroundColor: Colors.white12,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _currentPage == _steps.length - 1
                          ? tr('onboarding.persona.start_journey')
                          : tr('onboarding.persona.continue'),
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepPage(_OnboardingStep step, int index) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(step.icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 24),
          // Question
          Text(
            tr(step.question),
            style: GoogleFonts.cairo(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle
          Text(
            tr(step.subtitle),
            style: GoogleFonts.cairo(
              fontSize: 16,
              color: Colors.white60,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          // Input based on type
          if (step.type == _StepType.textInput)
            _buildTextInput()
          else if (step.type == _StepType.singleChoice)
            _buildChoiceGrid(step.options!, index),
        ],
      ),
    );
  }

  Widget _buildTextInput() {
    return TextField(
      autofocus: true,
      onChanged: (value) => setState(() => _name = value),
      style: GoogleFonts.cairo(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: tr('onboarding.persona.name_hint'),
        hintStyle: GoogleFonts.cairo(fontSize: 24, color: Colors.white30),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
      ),
    );
  }

  Widget _buildChoiceGrid(List<_Option> options, int stepIndex) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((option) {
        final isSelected = _getSelection(stepIndex) == option.value;
        return GestureDetector(
          onTap: () => _setSelection(stepIndex, option.value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? option.color.withOpacity(0.2)
                  : Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? option.color : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  option.icon,
                  color: isSelected ? option.color : Colors.white60,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  tr(option.label),
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? option.color : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String? _getSelection(int stepIndex) {
    switch (stepIndex) {
      case 1:
        return _primaryGoal;
      case 2:
        return _motivation;
      case 3:
        return _playStyle;
      default:
        return null;
    }
  }

  void _setSelection(int stepIndex, String value) {
    setState(() {
      switch (stepIndex) {
        case 1:
          _primaryGoal = value;
          break;
        case 2:
          _motivation = value;
          break;
        case 3:
          _playStyle = value;
          break;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

enum _StepType { textInput, singleChoice }

class _OnboardingStep {
  final String question;
  final String subtitle;
  final IconData icon;
  final _StepType type;
  final List<_Option>? options;

  _OnboardingStep({
    required this.question,
    required this.subtitle,
    required this.icon,
    required this.type,
    this.options,
  });
}

class _Option {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  _Option(this.value, this.label, this.icon, this.color);
}
