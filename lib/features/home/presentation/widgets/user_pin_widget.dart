import 'package:flutter/material.dart';

/// Widget that displays a user pin/marker with avatar and distance
class UserPinWidget extends StatelessWidget {
  final int avatarIndex;

  const UserPinWidget({super.key, required this.avatarIndex});

  String _getAvatarImageUrl(int index) {
    // Using diverse placeholder avatar images
    final avatarUrls = [
      'https://i.pravatar.cc/150?img=1', // Avatar 1
      'https://i.pravatar.cc/150?img=5', // Avatar 2
      'https://i.pravatar.cc/150?img=9', // Avatar 3
      'https://i.pravatar.cc/150?img=12', // Avatar 4
      'https://i.pravatar.cc/150?img=16', // Avatar 5
      'https://i.pravatar.cc/150?img=20', // Avatar 6
    ];
    return avatarUrls[index % avatarUrls.length];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar circle with green border and user photo
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF2D5F4F), // Dark green border
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              _getAvatarImageUrl(avatarIndex),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to warning icon if image fails to load
                return Container(
                  color: const Color(0xFFE8B17A),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFF2D5F4F),
                    size: 28,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: const Color(0xFFE8B17A),
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF2D5F4F),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Small arrow pointing down
        Transform.translate(
          offset: const Offset(0, 1),
          child: CustomPaint(size: const Size(12, 8), painter: _ArrowPainter()),
        ),
      ],
    );
  }
}

/// Custom painter for the downward arrow
class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          const Color(0xFF2D5F4F) // Dark green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0) // Top left
      ..lineTo(size.width / 2, size.height) // Bottom center (point)
      ..lineTo(size.width, 0) // Top right
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
