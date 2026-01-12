import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'dart:ui';
import '../../../../game/data/mock_game_repository.dart';
import '../../../../game/domain/models/game_models.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  late GameChallenge challenge;

  @override
  void initState() {
    super.initState();
    // Load mock data for the "Walk to Mecca" challenge
    challenge = MockGameRepository.getMeccaChallenge();
  }

  @override
  Widget build(BuildContext context) {
    // Define the path height based on design requirements
    const double pathHeight = 5000.0;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _getBiomeColors(challenge.biome),
          ),
        ),
        child: SingleChildScrollView(
          reverse: true, // Start at the bottom (start of the journey)
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: pathHeight,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final path = JourneyPathUtils.generatePath(
                  Size(width, pathHeight),
                );

                return Stack(
                  children: [
                    // 1. The Winding Path
                    Positioned.fill(
                      child: CustomPaint(
                        painter: JourneyPathPainter(
                          path: path,
                          progress: challenge.teamProgress,
                          biome: challenge.biome,
                        ),
                      ),
                    ),

                    // 2. Dynamic Milestones (Levels)
                    ..._buildMilestones(path, pathHeight),

                    // 3. Floating Avatars (Participants)
                    ...challenge.participants.map((participant) {
                      return _buildAvatarMarker(context, path, participant);
                    }),

                    // 4. Header Overlay
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: _buildHeader(context),
                    ),

                    // 5. Floating Controls
                    Positioned(
                      bottom: 40,
                      right: 20,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // TODO: Scroll to user
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getBiomeColors(BiomeType biome) {
    switch (biome) {
      case BiomeType.desert:
        return [const Color(0xFFFFF8E1), const Color(0xFFFFD54F)]; // Sand
      case BiomeType.forest:
        return [const Color(0xFFF1F8E9), const Color(0xFFAED581)]; // Green
      case BiomeType.ocean:
        return [const Color(0xFFE1F5FE), const Color(0xFF4FC3F7)]; // Blue
      case BiomeType.mountain:
        return [const Color(0xFFF5F5F5), const Color(0xFF90A4AE)]; // Gray
    }
  }

  Widget _buildAvatarMarker(
    BuildContext context,
    Path path,
    ParticipantProgress participant,
  ) {
    // Calculate position on path based on progress (0.0 to 1.0)
    final metrics = path.computeMetrics().first;
    // Reverse logic: 0% is at the bottom (end of path buffer), 100% is at top (start of buffer)?
    // Usually "start" is bottom for scrolling apps.
    // Let's assume Path is drawn Top->Bottom.
    // 0% Progress = Bottom of Screen (Length of Path)
    // 100% Progress = Top of Screen (0)

    final distance = metrics.length * (1 - participant.progress);
    final tangent = metrics.getTangentForOffset(distance);

    if (tangent == null) return const SizedBox.shrink();

    return Positioned(
      left: tangent.position.dx - 24, // Center the 48px avatar
      top: tangent.position.dy - 60, // Place atop the point
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Name Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              participant.user.displayName,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(participant.user.avatarUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Triangle Pointer
          ClipPath(
            clipper: TriangleClipper(),
            child: Container(width: 10, height: 8, color: Colors.white),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMilestones(Path path, double totalHeight) {
    final metrics = path.computeMetrics().first;
    List<Widget> milestones = [];

    // Create 5 milestones
    for (int i = 1; i <= 5; i++) {
      final percent = i / 6; // Spread them out
      final distance = metrics.length * percent;
      final tangent = metrics.getTangentForOffset(distance);

      if (tangent != null) {
        milestones.add(
          Positioned(
            left: tangent.position.dx + 20, // Offset to side of path
            top: tangent.position.dy,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.flag, size: 16, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    "Km ${((1 - percent) * 1500).toInt()}",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    return milestones;
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  const BoxShadow(color: Colors.black12, blurRadius: 10),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.groups, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    "Team: ${(challenge.teamProgress * 100).toStringAsFixed(1)}%",
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JourneyPathUtils {
  static Path generatePath(Size size) {
    final path = Path();
    // Start from top center (but conceptually the END of the journey in a reverse scroll)
    // We will draw from Top to Bottom.
    path.moveTo(size.width / 2, 0);

    // Create organic winding path
    // We break the height into segments
    double currentY = 0;
    bool isRight = true;

    while (currentY < size.height) {
      final nextY = currentY + 400;
      final controlX = isRight ? size.width * 0.9 : size.width * 0.1;
      final endX = size.width / 2; // Return to center? Or zig zag?
      // Let's zig zag
      final targetX = isRight ? size.width * 0.75 : size.width * 0.25;

      // Quadratic bezier for simple storage
      path.quadraticBezierTo(controlX, currentY + 200, targetX, nextY);

      currentY = nextY;
      isRight = !isRight;
    }
    return path;
  }
}

class JourneyPathPainter extends CustomPainter {
  final Path path;
  final double progress;
  final BiomeType biome;

  JourneyPathPainter({
    required this.path,
    required this.progress,
    required this.biome,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw the "Dirt" Path (Background)
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, bgPaint);

    // 2. Draw the Progress Line (Colored)
    // Calculate length based on progress.
    // Remember: Scroll is Reversed. Bottom is Start. Top is Finish.
    // If progress is 0.1 (10%), we start from Bottom and go up 10%.
    final metrics = path.computeMetrics().first;
    // Start index = total_length
    // End index = total_length * (1 - progress)
    final startOffset = metrics.length; // Bottom
    final endOffset = metrics.length * (1 - progress); // Further up

    // PathMetrics doesn't easily extract "from end to middle".
    // We should extract the sub-path.
    // Actually, let's just draw the active part which is from "Current Pos" to "Bottom".
    final activePath = metrics.extractPath(endOffset, startOffset);

    final activePaint = Paint()
      ..color = _getBiomeMainColor(biome)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(activePath, activePaint);

    // 3. Draw Dashed Center Line
    // ... (optional polish)
  }

  Color _getBiomeMainColor(BiomeType biome) {
    switch (biome) {
      case BiomeType.desert:
        return Colors.orange;
      case BiomeType.forest:
        return const Color(0xFF26F05F);
      case BiomeType.ocean:
        return Colors.blue;
      case BiomeType.mountain:
        return Colors.purple;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
