import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'benefit_detail_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2), // Light beige background
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 40,
                left: 24,
                right: 24,
                bottom: 60,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFF0EAE2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Benefits tailored to you',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w900, // Extra bold like visual
                      color: const Color(0xFF1A1A1A),
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Get them quickly and easily.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Content List
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 24),

                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFilterChip('All', true),
                        const SizedBox(width: 12),
                        _buildFilterChip('Wellness', false),
                        const SizedBox(width: 12),
                        _buildFilterChip('Protection', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Cards Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.70, // Adjust for card height
                    children: [
                      _buildBenefitCard(
                        context,
                        title: 'Bicycle\nInsurance',
                        price: '3.000',
                        icon: Icons.directions_bike,
                        iconColor: const Color(0xFF26F05F),
                        iconBg: const Color(0xFFE0FCE5),
                      ),
                      _buildBenefitCard(
                        context,
                        title: 'Take care of\nyour pet',
                        price: '3.000',
                        icon: Icons.pets,
                        iconColor: const Color(0xFF40E0D0),
                        iconBg: const Color(0xFFE0F9FA),
                      ),
                      _buildBenefitCard(
                        context,
                        title: 'Cancer\nInsurance',
                        price: '5.000',
                        icon: Icons.favorite,
                        iconColor: const Color(0xFFFF80EA),
                        iconBg: const Color(0xFFFDE6FA),
                      ),
                      _buildBenefitCard(
                        context,
                        title: 'Dental\ninsurance',
                        price: '2.000',
                        icon: Icons.medical_services,
                        iconColor: const Color(0xFFE8E81A),
                        iconBg: const Color(0xFFFCFCE0),
                      ),
                    ],
                  ),

                  // Bottom Padding so Nav Bar doesn't cover content
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1A1A1A) : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: isSelected ? Colors.white : const Color(0xFF666666),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildBenefitCard(
    BuildContext context, {
    required String title,
    required String price,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BenefitDetailScreen(
              title: title,
              icon: icon,
              iconColor: iconColor,
              iconBg: iconBg,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration Placeholder
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, size: 28, color: iconColor),
            ),
            const SizedBox(height: 12),

            // Texts
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$$price',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                        TextSpan(
                          text: ' / Monthly',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Buy Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Buy',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
