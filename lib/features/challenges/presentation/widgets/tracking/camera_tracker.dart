import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Camera tracker for photo-proof challenges
class CameraTracker extends StatefulWidget {
  final Function(String?) onComplete;

  const CameraTracker({super.key, required this.onComplete});

  @override
  State<CameraTracker> createState() => _CameraTrackerState();
}

class _CameraTrackerState extends State<CameraTracker> {
  String? _photoPath;
  bool _isSubmitted = false;

  Future<void> _takePhoto() async {
    // TODO: Implement camera integration
    // For now, simulate taking a photo
    setState(() {
      _photoPath = 'placeholder_photo_path';
    });
  }

  void _submit() {
    if (_photoPath != null) {
      setState(() => _isSubmitted = true);
      widget.onComplete(_photoPath);
    }
  }

  void _retake() {
    setState(() {
      _photoPath = null;
      _isSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      return _buildSubmittedView();
    }

    return Column(
      children: [
        // Photo preview or camera button
        GestureDetector(
          onTap: _takePhoto,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: _photoPath != null ? Colors.grey[200] : Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _photoPath != null
                    ? const Color(0xFF26F05F)
                    : Colors.grey[300]!,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: _photoPath != null
                ? Stack(
                    children: [
                      // Placeholder for actual photo
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.photo,
                              size: 64,
                              color: Color(0xFF26F05F),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Photo captured!',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF26F05F),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Retake button
                      Positioned(
                        top: 12,
                        right: 12,
                        child: GestureDetector(
                          onTap: _retake,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.refresh,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 36,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tap to take photo',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Show proof of your achievement',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 20),
        // Submit button
        if (_photoPath != null)
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF26F05F),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check),
                const SizedBox(width: 8),
                Text(
                  'Submit Photo',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSubmittedView() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF26F05F).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF26F05F)),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF26F05F), size: 56),
          const SizedBox(height: 12),
          Text(
            'Photo Submitted! 📸',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF26F05F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your friends can now see your proof',
            style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
