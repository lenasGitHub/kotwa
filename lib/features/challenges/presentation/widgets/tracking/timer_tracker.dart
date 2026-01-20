import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/challenge.dart';

/// Timer/Stopwatch tracker with beautiful circular display
class TimerTracker extends StatefulWidget {
  final TimerConfig? config;
  final bool isStopwatch; // true = count up, false = countdown to target
  final Function(Duration) onComplete;

  const TimerTracker({
    super.key,
    this.config,
    required this.isStopwatch,
    required this.onComplete,
  });

  @override
  State<TimerTracker> createState() => _TimerTrackerState();
}

class _TimerTrackerState extends State<TimerTracker> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;
  bool _isComplete = false;

  Duration get _targetDuration =>
      widget.config?.targetDuration ?? const Duration(minutes: 30);

  double get _progress {
    if (widget.isStopwatch) {
      // Stopwatch: no target, just keep going
      return 0.0; // No progress ring for stopwatch
    }
    return (_elapsed.inSeconds / _targetDuration.inSeconds).clamp(0.0, 1.0);
  }

  String get _displayTime {
    final minutes = _elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = _elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hours = _elapsed.inHours;

    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  void _toggleTimer() {
    if (_isRunning) {
      _pauseTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed += const Duration(seconds: 1);

        // Check if target reached (for countdown mode)
        if (!widget.isStopwatch && _elapsed >= _targetDuration) {
          _completeTimer();
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _elapsed = Duration.zero;
      _isRunning = false;
      _isComplete = false;
    });
  }

  void _completeTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isComplete = true;
    });
    widget.onComplete(_elapsed);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Timer display
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: _isComplete
                    ? const Color(0xFF26F05F).withOpacity(0.3)
                    : _isRunning
                    ? const Color(0xFF2196F3).withOpacity(0.2)
                    : Colors.black.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Progress ring (only for timer mode, not stopwatch)
              if (!widget.isStopwatch)
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: _progress,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _isComplete
                          ? const Color(0xFF26F05F)
                          : const Color(0xFF2196F3),
                    ),
                  ),
                ),
              // Time display
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isComplete)
                    const Text('🎉', style: TextStyle(fontSize: 32)),
                  Text(
                    _displayTime,
                    style: GoogleFonts.inter(
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                      color: _isComplete
                          ? const Color(0xFF26F05F)
                          : const Color(0xFF1A1A1A),
                    ),
                  ),
                  if (!widget.isStopwatch && !_isComplete)
                    Text(
                      '/ ${_targetDuration.inMinutes} min',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Reset button
            if (_elapsed > Duration.zero)
              IconButton(
                onPressed: _resetTimer,
                icon: const Icon(Icons.refresh),
                iconSize: 28,
                color: Colors.grey[500],
              ),
            const SizedBox(width: 16),
            // Play/Pause button
            GestureDetector(
              onTap: _isComplete ? null : _toggleTimer,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  gradient: _isComplete
                      ? const LinearGradient(
                          colors: [Color(0xFF26F05F), Color(0xFF00C853)],
                        )
                      : _isRunning
                      ? const LinearGradient(
                          colors: [Color(0xFFFF5722), Color(0xFFE64A19)],
                        )
                      : const LinearGradient(
                          colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                        ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color:
                          (_isComplete
                                  ? const Color(0xFF26F05F)
                                  : _isRunning
                                  ? const Color(0xFFFF5722)
                                  : const Color(0xFF2196F3))
                              .withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  _isComplete
                      ? Icons.check
                      : _isRunning
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Complete button (for stopwatch mode)
            if (widget.isStopwatch && _elapsed > Duration.zero && !_isComplete)
              IconButton(
                onPressed: _completeTimer,
                icon: const Icon(Icons.check_circle),
                iconSize: 28,
                color: const Color(0xFF26F05F),
              ),
          ],
        ),
      ],
    );
  }
}
