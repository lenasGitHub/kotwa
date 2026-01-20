import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Text input tracker for journal/note challenges
class TextTracker extends StatefulWidget {
  final Function(String) onComplete;
  final String? placeholder;
  final int minLength;

  const TextTracker({
    super.key,
    required this.onComplete,
    this.placeholder,
    this.minLength = 10,
  });

  @override
  State<TextTracker> createState() => _TextTrackerState();
}

class _TextTrackerState extends State<TextTracker> {
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitted = false;

  bool get _canSubmit => _controller.text.trim().length >= widget.minLength;

  void _submit() {
    if (_canSubmit) {
      setState(() => _isSubmitted = true);
      widget.onComplete(_controller.text.trim());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      return _buildSubmittedView();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Text input
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _controller,
            maxLines: 5,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey[800],
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: widget.placeholder ?? 'Write your thoughts...',
              hintStyle: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.grey[400],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Character count
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_controller.text.length} characters',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: _canSubmit ? Colors.grey[500] : Colors.orange,
              ),
            ),
            if (!_canSubmit)
              Text(
                'Min ${widget.minLength} characters required',
                style: GoogleFonts.inter(fontSize: 13, color: Colors.orange),
              ),
          ],
        ),
        const SizedBox(height: 16),
        // Submit button
        ElevatedButton(
          onPressed: _canSubmit ? _submit : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF26F05F),
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[300],
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Submit Entry',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmittedView() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF26F05F).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF26F05F)),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF26F05F), size: 48),
          const SizedBox(height: 12),
          Text(
            'Entry Saved! 🎉',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF26F05F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _controller.text,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
