import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F5F5), // Light gray/white at top
              Color(0xFFD4F4DD), // Mint green at bottom
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: Stack(
          children: [
            // Main scrollable content - Reversed to scroll from bottom to top
            SingleChildScrollView(
              reverse: true, // Scroll from bottom to top
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 120), // Space for bottom icons
                  // Journey Path - Extended for infinite scroll
                  SizedBox(
                    height: 5000, // Much longer height for continuous scrolling
                    child: CustomPaint(
                      painter: JourneyPathPainter(),
                      child: Stack(
                        children: [
                          // Top Dollar Icon
                          Positioned(
                            top: 50,
                            left: MediaQuery.of(context).size.width / 2 - 30,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.attach_money,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),

                          // Nivel 400 - with avatars
                          Positioned(
                            top: 180,
                            right: 80,
                            child: Column(
                              children: [
                                // Avatars
                                SizedBox(
                                  width: 80,
                                  height: 40,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        child: _buildAvatar(
                                          'https://i.pravatar.cc/100?img=1',
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        child: _buildAvatar(
                                          'https://i.pravatar.cc/100?img=2',
                                        ),
                                      ),
                                      Positioned(
                                        left: 40,
                                        child: _buildAvatar(
                                          'https://i.pravatar.cc/100?img=3',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Nivel badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Nivel 400',
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
                                ),
                              ],
                            ),
                          ),

                          // 96 Badge
                          Positioned(
                            top: 320,
                            left: 40,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '96',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 450 Badge
                          Positioned(
                            top: 380,
                            left: 30,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '450',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.filter_vintage,
                                    size: 18,
                                    color: Color(0xFF26F05F),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // User Avatar - positioned on path
                          Positioned(
                            top: 500,
                            right: 60,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Green ring
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF26F05F,
                                    ).withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                // Avatar
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF26F05F),
                                      width: 4,
                                    ),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                        'https://i.pravatar.cc/150?img=68',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // +1 badge
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF26F05F),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '+1',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 200 Badge
                          Positioned(
                            top: 620,
                            right: 100,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '200',
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
                            ),
                          ),

                          // Pink Heart Icon
                          Positioned(
                            top: 750,
                            right: 40,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF80EA),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),

                          // Nivel 100 - with avatars
                          Positioned(
                            top: 900,
                            left: 80,
                            child: Column(
                              children: [
                                // Avatars
                                SizedBox(
                                  width: 60,
                                  height: 40,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        child: _buildAvatar(
                                          'https://i.pravatar.cc/100?img=4',
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        child: _buildAvatar(
                                          'https://i.pravatar.cc/100?img=5',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Nivel badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Nivel 100',
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Header - New compact design
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://i.pravatar.cc/100?img=68',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Stats Row
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Butterfly stat
                              Row(
                                children: [
                                  const Icon(
                                    Icons.filter_vintage,
                                    color: Color(0xFF26F05F),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '260/300',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                ],
                              ),

                              // Heart stat
                              Row(
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    color: Color(0xFFFF80EA),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '18',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                ],
                              ),

                              // Shield stat
                              Row(
                                children: [
                                  const Icon(
                                    Icons.security,
                                    color: Color(0xFF40E0D0),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '\$ 1.2M',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Hamburger menu
                        const Icon(
                          Icons.menu,
                          size: 28,
                          color: Color(0xFF1A1A1A),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom left backpack icon
            Positioned(
              bottom: 30,
              left: 30,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF26F05F),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.backpack,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),

            // Bottom right compass icon
            Positioned(
              bottom: 30,
              right: 30,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.explore,
                    color: Color(0xFF1A1A1A),
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String imageUrl) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Custom painter for the winding path
class JourneyPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the active (completed) section background
    final activeBgPaint = Paint()
      ..color = const Color(0xFF26F05F).withOpacity(0.15)
      ..strokeWidth = 30
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Paint for active (green) dashed line
    final activeDashedPaint = Paint()
      ..color = const Color(0xFF26F05F)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Paint for inactive (gray) dashed line
    final inactiveDashedPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Start from top center
    path.moveTo(size.width / 2, 50);

    // Create winding path
    path.quadraticBezierTo(size.width * 0.8, 150, size.width * 0.7, 250);

    path.quadraticBezierTo(size.width * 0.5, 350, size.width * 0.3, 450);

    path.quadraticBezierTo(size.width * 0.1, 550, size.width * 0.6, 650);

    path.quadraticBezierTo(size.width * 0.9, 750, size.width * 0.7, 850);

    path.quadraticBezierTo(size.width * 0.4, 950, size.width * 0.3, 1050);

    // Continue the path further down
    path.quadraticBezierTo(size.width * 0.2, 1150, size.width * 0.6, 1250);

    path.quadraticBezierTo(size.width * 0.8, 1350, size.width * 0.5, 1450);

    path.quadraticBezierTo(size.width * 0.3, 1550, size.width * 0.7, 1650);

    path.quadraticBezierTo(size.width * 0.9, 1750, size.width * 0.4, 1850);

    path.quadraticBezierTo(size.width * 0.2, 1950, size.width * 0.6, 2050);

    path.quadraticBezierTo(size.width * 0.8, 2150, size.width * 0.3, 2250);

    path.quadraticBezierTo(size.width * 0.1, 2350, size.width * 0.7, 2450);

    path.quadraticBezierTo(size.width * 0.9, 2550, size.width * 0.5, 2650);

    path.quadraticBezierTo(size.width * 0.3, 2750, size.width * 0.6, 2850);

    path.quadraticBezierTo(size.width * 0.8, 2950, size.width * 0.4, 3050);

    path.quadraticBezierTo(size.width * 0.2, 3150, size.width * 0.7, 3250);

    path.quadraticBezierTo(size.width * 0.9, 3350, size.width * 0.3, 3450);

    path.quadraticBezierTo(size.width * 0.1, 3550, size.width * 0.6, 3650);

    path.quadraticBezierTo(size.width * 0.8, 3750, size.width * 0.5, 3850);

    path.quadraticBezierTo(size.width * 0.3, 3950, size.width * 0.7, 4050);

    path.quadraticBezierTo(size.width * 0.9, 4150, size.width * 0.4, 4250);

    path.quadraticBezierTo(size.width * 0.2, 4350, size.width * 0.6, 4450);

    path.quadraticBezierTo(size.width * 0.8, 4550, size.width * 0.5, 4650);

    path.quadraticBezierTo(size.width * 0.3, 4750, size.width * 0.5, 4850);

    // Calculate the active portion (e.g., 60% completed)
    final metrics = path.computeMetrics().first;
    final activeLength = metrics.length * 0.6; // 60% of the path is active

    // Extract active and inactive paths
    final activePath = metrics.extractPath(0, activeLength);
    final inactivePath = metrics.extractPath(activeLength, metrics.length);

    // Draw active section with green background
    canvas.drawPath(activePath, activeBgPaint);

    // Draw active section with green dashed line
    _drawDashedPath(canvas, activePath, activeDashedPaint);

    // Draw inactive section with gray dashed line
    _drawDashedPath(canvas, inactivePath, inactiveDashedPaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 10.0;
    const dashSpace = 8.0;

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      bool draw = true;

      while (distance < metric.length) {
        final length = draw ? dashWidth : dashSpace;
        final end = math.min(distance + length, metric.length);

        if (draw) {
          final extractPath = metric.extractPath(distance, end);
          canvas.drawPath(extractPath, paint);
        }

        distance = end;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
