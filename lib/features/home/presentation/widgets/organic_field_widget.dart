import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'user_pin_widget.dart';
import '../../../challenges/domain/models/tracking_type.dart';

/// Data model for pin information
class PinData {
  final int? avatarIndex;
  final String? odeName;
  final String? avatarUrl;
  final String? name;

  PinData({this.avatarIndex, this.odeName, this.avatarUrl, this.name});
}

/// Data model for each field item
class FieldItem {
  final int id;
  final ChallengeCategory? category;
  final int crossAxisCellCount; // Width in grid cells
  final int mainAxisCellCount; // Height in grid cells
  final String title;
  final String subtitle;
  final IconData? icon;
  final Color? color;
  final List<PinData> pins; // List of pins for this field
  final int participantCount;

  FieldItem({
    required this.id,
    this.category,
    required this.crossAxisCellCount,
    required this.mainAxisCellCount,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color,
    this.pins = const [],
    this.participantCount = 0,
  });
}

/// Individual organic field widget
class OrganicFieldWidget extends StatelessWidget {
  final FieldItem fieldItem;
  final bool isSelected;
  final VoidCallback onTap;

  const OrganicFieldWidget({
    super.key,
    required this.fieldItem,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Smaller base height so more shapes fit on screen
    final baseHeight = 120.0;
    final height =
        baseHeight * fieldItem.mainAxisCellCount; // Fixed height calc

    final random = math.Random(fieldItem.id);

    // const List<List<Color>> bubbleGradients = [
    //       [Color(0xFFFFD88E), Color(0xFFE88A2A)],
    //       [Color(0xFFFFB89B), Color(0xFFFF4A1A)],
    //       [Color(0xFFF8BBEB), Color(0xFFD84AB8)],
    //       [Color(0xFFABF0F8), Color(0xFF3AB8D8)],
    //       [Color(0xFFD8F8AB), Color(0xFF7AC850)],
    //       [Color(0xFFB8D8FF), Color(0xFF4A88E8)],
    //     ];

    //     final gradientColors =
    //         bubbleGradients[fieldItem.id % bubbleGradients.length];
    // Generate greenish colors like reference image (pale mint/sage)
    final hue = 110 + random.nextDouble() * 20; // Greenish hues (110-130)
    final generatedColor = HSLColor.fromAHSL(
      1.0,
      hue,
      0.25, // Subtle saturation
      0.94, // Very light background
    ).toColor();

    final defaultColor = fieldItem.color?.withOpacity(0.3) ?? generatedColor;

    // final selectedColor = const Color(0xFF8CDD9C); // Green when selected
    final selectedColor =
        fieldItem.color?.withOpacity(0.6) ??
        HSLColor.fromAHSL(
          1.0,
          120, // Pure Green when selected
          0.60,
          0.80,
        ).toColor();

    final fillColor = isSelected ? selectedColor : defaultColor;

    // final decoration = isSelected
    //         ? BoxDecoration(color: selectedColor)
    //         : BoxDecoration(
    //             gradient: LinearGradient(
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight,
    //               colors: gradientColors,
    //             ),
    //           );
    final decoration = BoxDecoration(color: fillColor);

    final patternColor = Colors.black.withOpacity(0.08); // Subtle lines

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: const BoxDecoration(color: Colors.transparent),
        clipBehavior: Clip.none, // Allow pins to extend beyond bounds
        child: Stack(
          clipBehavior: Clip.none, // Allow overflow
          children: [
            // 1. Clipped Fill and Pattern
            ClipPath(
              clipper: OrganicShapeClipper(seed: fieldItem.id),
              child: Container(
                decoration: decoration,
                child: Stack(
                  children: [
                    // Diagonal Pattern Layer
                    Positioned.fill(
                      child: CustomPaint(
                        painter: DiagonalPatternPainter(
                          color: patternColor,
                          spacing: 8.0,
                        ),
                      ),
                    ),
                    // Dashed Border Layer (inside clip)
                    Positioned.fill(
                      child: CustomPaint(
                        painter: DashedBorderPainter(
                          seed: fieldItem.id,
                          color: const Color(0xFF535d55),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content Layer (Icon, Title, Subtitle) - outside clip for visibility
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Circular Icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF3E4E3E),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        fieldItem.icon ?? Icons.error,
                        size: 20,
                        color: const Color(0xFF3E4E3E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Title
                    Text(
                      fieldItem.title,
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E2E1E),
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    // Subtitle
                    Text(
                      fieldItem.subtitle,
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF5E6E5E),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // Add pin markers around the title (center area)
            ...fieldItem.pins.asMap().entries.map((entry) {
              final index = entry.key;
              final pin = entry.value;
              final totalPins = fieldItem.pins.length;

              // Position pins in a circular arrangement around center
              double? left;
              double? right;
              double top = height / 2 - 80; // Position relative to center

              if (totalPins == 1) {
                right = 30;
              } else if (totalPins == 2) {
                if (index == 0) {
                  left = 30;
                } else {
                  right = 30;
                }
              } else {
                // 3 or more pins
                if (index == 0) {
                  left = 20;
                } else if (index == 1) {
                  left = null;
                  right = null;
                  // Center pin
                } else {
                  right = 20;
                }
              }

              return Positioned(
                top: top,
                left: left,
                right: right,
                child: UserPinWidget(avatarIndex: pin.avatarIndex ?? 0),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// Custom clipper to create organic shapes
class OrganicShapeClipper extends CustomClipper<Path> {
  final int seed;

  OrganicShapeClipper({required this.seed});

  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final double margin = 3.0; // Reduced internal margin
    final centerX = w / 2;
    final centerY = h / 2;
    final numPoints = 12;
    final plotPoints = <Offset>[];

    for (int i = 0; i < numPoints; i++) {
      double angle = (i / numPoints) * 2 * math.pi;
      double cosA = math.cos(angle);
      double sinA = math.sin(angle);
      double rMax = math.min(
        (w / 2 - margin) / (cosA.abs() + 0.01),
        (h / 2 - margin) / (sinA.abs() + 0.01),
      );
      double variation = math.sin(seed * 0.1 + i * 2.7) * 0.5 + 0.5;
      double irregularity = 0.85 + variation * 0.15;
      double r = rMax * irregularity;
      plotPoints.add(Offset(centerX + r * cosA, centerY + r * sinA));
    }

    path.moveTo(plotPoints[0].dx, plotPoints[0].dy);
    for (int i = 0; i < plotPoints.length; i++) {
      final p0 = plotPoints[(i - 1 + plotPoints.length) % plotPoints.length];
      final p1 = plotPoints[i];
      final p2 = plotPoints[(i + 1) % plotPoints.length];
      final p3 = plotPoints[(i + 2) % plotPoints.length];
      final cp1 = Offset(
        p1.dx + (p2.dx - p0.dx) * 0.2,
        p1.dy + (p2.dy - p0.dy) * 0.2,
      );
      final cp2 = Offset(
        p2.dx - (p3.dx - p1.dx) * 0.2,
        p2.dy - (p3.dy - p1.dy) * 0.2,
      );
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(OrganicShapeClipper oldClipper) => oldClipper.seed != seed;
}

/// Painter for diagonal hatching lines
class DiagonalPatternPainter extends CustomPainter {
  final Color color;
  final double spacing;

  DiagonalPatternPainter({required this.color, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final total = size.width + size.height;
    for (double i = 0; i < total; i += spacing) {
      double x1 = (i <= size.height) ? 0 : i - size.height;
      double y1 = (i <= size.height) ? i : size.height;
      double x2 = (i <= size.width) ? i : size.width;
      double y2 = (i <= size.width) ? 0 : i - size.width;
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(DiagonalPatternPainter oldDelegate) => false;
}

/// Custom painter for dashed border
class DashedBorderPainter extends CustomPainter {
  final int seed;
  final Color color;

  DashedBorderPainter({required this.seed, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final clipper = OrganicShapeClipper(seed: seed);
    final path = clipper.getClip(size);
    final paint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    final dashWidth = 6.0;
    final dashSpace = 4.0;
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
  bool shouldRepaint(DashedBorderPainter oldDelegate) => false;
}
