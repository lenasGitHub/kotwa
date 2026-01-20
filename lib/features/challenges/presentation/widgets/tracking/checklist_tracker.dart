import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/models/challenge.dart';

/// Checklist tracker for multi-item challenges (e.g., 5 daily prayers)
class ChecklistTracker extends StatefulWidget {
  final ChecklistConfig config;
  final Function(List<bool>) onComplete;

  const ChecklistTracker({
    super.key,
    required this.config,
    required this.onComplete,
  });

  @override
  State<ChecklistTracker> createState() => _ChecklistTrackerState();
}

class _ChecklistTrackerState extends State<ChecklistTracker> {
  late List<bool> _checked;

  @override
  void initState() {
    super.initState();
    _checked = List.filled(widget.config.items.length, false);
  }

  void _toggleItem(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _checked[index] = !_checked[index];
    });

    // Check if all items are complete
    if (_checked.every((item) => item)) {
      widget.onComplete(_checked);
    }
  }

  int get _completedCount => _checked.where((c) => c).length;
  double get _progress => _completedCount / _checked.length;
  bool get _isAllComplete => _checked.every((c) => c);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isAllComplete
                ? const Color(0xFF26F05F).withOpacity(0.1)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Progress ring
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 5,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _isAllComplete
                            ? const Color(0xFF26F05F)
                            : const Color(0xFF2196F3),
                      ),
                    ),
                    Text(
                      '$_completedCount/${_checked.length}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isAllComplete ? 'All Complete! 🎉' : 'In Progress',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _isAllComplete
                            ? const Color(0xFF26F05F)
                            : Colors.grey[700],
                      ),
                    ),
                    Text(
                      '$_completedCount of ${_checked.length} items done',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Checklist items
        ...List.generate(widget.config.items.length, (index) {
          return _buildChecklistItem(index);
        }),
      ],
    );
  }

  Widget _buildChecklistItem(int index) {
    final isChecked = _checked[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => _toggleItem(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isChecked
                ? const Color(0xFF26F05F).withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isChecked ? const Color(0xFF26F05F) : Colors.grey[300]!,
              width: isChecked ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: isChecked
                      ? const Color(0xFF26F05F)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isChecked
                        ? const Color(0xFF26F05F)
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                ),
                child: isChecked
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  widget.config.items[index],
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: isChecked ? FontWeight.w600 : FontWeight.w500,
                    color: isChecked
                        ? const Color(0xFF26F05F)
                        : Colors.grey[700],
                    decoration: isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
