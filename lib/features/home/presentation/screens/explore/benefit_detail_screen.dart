import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'journey_screen.dart';

class BenefitDetailScreen extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const BenefitDetailScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  @override
  State<BenefitDetailScreen> createState() => _BenefitDetailScreenState();
}

class _BenefitDetailScreenState extends State<BenefitDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Header Image with curved bottom
                Stack(
                  children: [
                    // Background Image
                    Container(
                      width: double.infinity,
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1551632811-561732d1e306?w=800&q=80',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Gradient overlay for better text visibility
                    Container(
                      width: double.infinity,
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // White content card
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // REGISTERED Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'REGISTERED',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // GROUP CHALLENGE Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8B4F0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'GROUP CHALLENGE',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF7B1FA2),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Title
                        Text(
                          'Take steps and help!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bebasNeue(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF1A1A1A),
                            letterSpacing: 0.5,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Butterfly Icon with Points
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.filter_vintage,
                              color: widget.iconColor,
                              size: 32,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '150',
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Description
                        Text(
                          'Walk up to 20,000 steps in 10 days to\nearn an extra 200 Betterflies!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            height: 1.6,
                            color: const Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Countdown Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F5F2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              // Calendar icon with text
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Just 4 days left until the challenge ends',
                                      style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF1A1A1A),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Progress Bar
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: 0.7, // 14,000 / 20,000 = 0.7
                                  minHeight: 12,
                                  backgroundColor: Colors.grey.shade300,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Color(0xFF26F05F),
                                      ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Progress Details
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Betterflies earned
                                  Row(
                                    children: [
                                      Text(
                                        'Betterflies earned: ',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: const Color(0xFF666666),
                                        ),
                                      ),
                                      Text(
                                        '+50',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF1A1A1A),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(
                                        Icons.filter_vintage,
                                        size: 16,
                                        color: Color(0xFF26F05F),
                                      ),
                                    ],
                                  ),
                                  // Steps progress
                                  RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: const Color(0xFF666666),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '14,000',
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF1A1A1A),
                                          ),
                                        ),
                                        const TextSpan(
                                          text: ' / 20,000\nsteps',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        // View Journey Button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const JourneyScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF26F05F),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF26F05F,
                                  ).withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Text(
                              'View Journey',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 100), // Bottom padding for safe area
              ],
            ),
          ),

          // Back Button (positioned absolutely)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
