import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/challenge.dart';

/// Counter tracker with tap-to-increment and beautiful animations
class CounterTracker extends StatefulWidget {
  final CounterConfig config;
  final Function(int) onComplete;

  const CounterTracker({
    super.key,
    required this.config,
    required this.onComplete,
  });

  @override
  State<CounterTracker> createState() => _CounterTrackerState();
}

class _CounterTrackerState extends State<CounterTracker>
    with SingleTickerProviderStateMixin {
  int _count = 0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _increment() {
    HapticFeedback.lightImpact();
    _pulseController.forward().then((_) => _pulseController.reverse());

    setState(() {
      _count++;
      if (_count >= widget.config.targetValue) {
        widget.onComplete(_count);
      }
    });
  }

  void _decrement() {
    if (_count > 0) {
      HapticFeedback.lightImpact();
      setState(() {
        _count--;
      });
    }
  }

  double get _progress => _count / widget.config.targetValue;
  bool get _isComplete => _count >= widget.config.targetValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress ring with counter
        GestureDetector(
          onTap: _increment,
          child: ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: _isComplete
                        ? const Color(0xFF26F05F).withOpacity(0.3)
                        : Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Progress ring
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: CircularProgressIndicator(
                      value: _progress.clamp(0.0, 1.0),
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _isComplete
                            ? const Color(0xFF26F05F)
                            : const Color(0xFF2196F3),
                      ),
                    ),
                  ),
                  // Counter display
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isComplete ? '🎉' : '$_count',
                        style: GoogleFonts.inter(
                          fontSize: _isComplete ? 48 : 48,
                          fontWeight: FontWeight.bold,
                          color: _isComplete
                              ? const Color(0xFF26F05F)
                              : const Color(0xFF1A1A1A),
                        ),
                      ),
                      if (!_isComplete)
                        Text(
                          '/ ${widget.config.targetValue}',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Unit label
        if (widget.config.unit.isNotEmpty)
          Text(
            widget.config.unit,
            style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600]),
          ),
        const SizedBox(height: 16),
        // +/- buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(Icons.remove, _decrement, Colors.grey[200]!),
            const SizedBox(width: 24),
            Text(
              'Tap circle to add',
              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[500]),
            ),
            const SizedBox(width: 24),
            _buildButton(Icons.add, _increment, const Color(0xFF26F05F)),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(
          icon,
          color: color == Colors.grey[200] ? Colors.grey[600] : Colors.white,
        ),
      ),
    );
  }
}
