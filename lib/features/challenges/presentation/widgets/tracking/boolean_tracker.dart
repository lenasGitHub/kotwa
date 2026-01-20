import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/challenge.dart';

/// Boolean (Yes/No) tracker widget with beautiful toggle
class BooleanTracker extends StatefulWidget {
  final Challenge challenge;
  final Function(bool) onComplete;
  final String? customLabel;
  final IconData? customIcon;

  const BooleanTracker({
    super.key,
    required this.challenge,
    required this.onComplete,
    this.customLabel,
    this.customIcon,
  });

  @override
  State<BooleanTracker> createState() => _BooleanTrackerState();
}

class _BooleanTrackerState extends State<BooleanTracker>
    with SingleTickerProviderStateMixin {
  bool _isCompleted = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleComplete() {
    // Check if time-locked
    if (widget.challenge.timeLockConfig != null &&
        widget.challenge.timeLockConfig!.isLocked) {
      _showLockedMessage();
      return;
    }

    _controller.forward().then((_) {
      _controller.reverse();
    });

    setState(() {
      _isCompleted = !_isCompleted;
    });
    widget.onComplete(_isCompleted);
  }

  void _showLockedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.challenge.timeLockConfig?.lockedMessage ??
              "Too late! Try again tomorrow 😅",
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLocked = widget.challenge.timeLockConfig?.isLocked ?? false;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: _toggleComplete,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            gradient: _isCompleted
                ? const LinearGradient(
                    colors: [Color(0xFF26F05F), Color(0xFF00C853)],
                  )
                : null,
            color: _isCompleted
                ? null
                : isLocked
                ? Colors.grey[300]
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _isCompleted
                    ? const Color(0xFF26F05F).withOpacity(0.3)
                    : Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  _isCompleted
                      ? Icons.check_circle
                      : isLocked
                      ? Icons.lock_clock
                      : widget.customIcon ?? Icons.radio_button_unchecked,
                  key: ValueKey(_isCompleted),
                  size: 32,
                  color: _isCompleted
                      ? Colors.white
                      : isLocked
                      ? Colors.grey[500]
                      : Colors.grey[400],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _isCompleted
                    ? 'Done! 🎉'
                    : isLocked
                    ? 'Locked ⏰'
                    : widget.customLabel ?? 'Mark as Done',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _isCompleted
                      ? Colors.white
                      : isLocked
                      ? Colors.grey[500]
                      : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
