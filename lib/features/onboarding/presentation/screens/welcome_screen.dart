import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker_challenge/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'onboarding_persona_screen.dart';

class WelcomeScreen extends StatefulWidget {
  final String language;
  final bool isRTL;

  const WelcomeScreen({super.key, required this.language, required this.isRTL});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.welcomeBlue, AppColors.welcomeBlueDark],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Decorative elements
              _buildDecorativeElements(size),
              // Main content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    // App logo/name
                    _buildAppHeader(),
                    const Spacer(flex: 2),
                    // Main illustration
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildIllustration(size),
                      ),
                    ),
                    const Spacer(flex: 1),
                    // Title and subtitle
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildTextContent(),
                    ),
                    const Spacer(flex: 2),
                    // Continue button
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildContinueButton(),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeElements(Size size) {
    return Stack(
      children: [
        // Stars and shapes
        Positioned(top: 100, left: 40, child: _buildStar(20)),
        Positioned(top: 150, right: 60, child: _buildStar(16)),
        Positioned(top: 250, right: 30, child: _buildStar(24)),
        Positioned(bottom: 200, left: 50, child: _buildStar(18)),
        Positioned(bottom: 300, right: 80, child: _buildStar(22)),
        // Floating shapes
        Positioned(
          top: 120,
          right: 20,
          child: _buildFloatingShape(
            color: Colors.white.withOpacity(0.2),
            size: 60,
          ),
        ),
        Positioned(
          bottom: 250,
          left: 30,
          child: _buildFloatingShape(
            color: Colors.white.withOpacity(0.15),
            size: 80,
          ),
        ),
      ],
    );
  }

  Widget _buildStar(double size) {
    return Icon(
      Icons.auto_awesome,
      color: Colors.white.withOpacity(0.6),
      size: size,
    );
  }

  Widget _buildFloatingShape({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildAppHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.check,
            color: AppColors.welcomeBlue,
            size: 30,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          tr('app.name'),
          style: GoogleFonts.cairo(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildIllustration(Size size) {
    return Container(
      width: size.width * 0.7,
      height: size.width * 0.7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
      ),
      child: Center(
        child: Container(
          width: size.width * 0.5,
          height: size.width * 0.5,
          decoration: BoxDecoration(
            color: Colors.pink.shade200,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.pink.shade200.withOpacity(0.5),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Brain illustration (simplified)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Eyes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildEye(),
                        const SizedBox(width: 20),
                        _buildEye(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Smile
                    Container(
                      width: 40,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white, width: 3),
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Decorative elements around
              Positioned(
                top: 20,
                left: -10,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                right: -15,
                child: Transform.rotate(
                  angle: 0.5,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red.shade300,
                      borderRadius: BorderRadius.circular(10),
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

  Widget _buildEye() {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 15,
          height: 15,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      children: [
        Text(
          tr('welcome_screen.title'),
          style: GoogleFonts.cairo(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          tr('welcome_screen.subtitle'),
          style: GoogleFonts.cairo(
            fontSize: 16,
            color: Colors.white.withOpacity(0.9),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => OnboardingPersonaScreen(
                language: widget.language,
                isRTL: widget.isRTL,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.welcomeBlue,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        child: Text(
          tr('welcome_screen.continue_button'),
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.welcomeBlue,
          ),
        ),
      ),
    );
  }
}
