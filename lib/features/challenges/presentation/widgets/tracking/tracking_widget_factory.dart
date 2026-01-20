import 'package:flutter/material.dart';
import '../../../domain/models/challenge.dart';
import '../../../domain/models/tracking_type.dart';
import 'boolean_tracker.dart';
import 'counter_tracker.dart';
import 'timer_tracker.dart';
import 'checklist_tracker.dart';
import 'text_tracker.dart';
import 'camera_tracker.dart';

/// Factory widget that returns the appropriate tracking widget based on type
class TrackingWidgetFactory extends StatelessWidget {
  final Challenge challenge;
  final Function(dynamic value) onComplete;
  final Function(String? photoPath)? onPhotoTaken;
  final VoidCallback? onReactionTap;

  const TrackingWidgetFactory({
    super.key,
    required this.challenge,
    required this.onComplete,
    this.onPhotoTaken,
    this.onReactionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main tracking widget based on type
        _buildTrackingWidget(),

        // Optional camera proof button (available on ALL types per user request)
        if (challenge.allowCameraProof) ...[
          const SizedBox(height: 16),
          CameraProofButton(onPhotoTaken: onPhotoTaken),
        ],
      ],
    );
  }

  Widget _buildTrackingWidget() {
    switch (challenge.trackingType) {
      case TrackingType.boolean:
      case TrackingType.timeLocked:
        return BooleanTracker(
          challenge: challenge,
          onComplete: (value) => onComplete(value),
        );

      case TrackingType.counter:
        return CounterTracker(
          config: challenge.counterConfig!,
          onComplete: (value) => onComplete(value),
        );

      case TrackingType.timer:
      case TrackingType.stopwatch:
        return TimerTracker(
          config: challenge.timerConfig,
          isStopwatch: challenge.trackingType == TrackingType.stopwatch,
          onComplete: (duration) => onComplete(duration),
        );

      case TrackingType.checklist:
        return ChecklistTracker(
          config: challenge.checklistConfig!,
          onComplete: (values) => onComplete(values),
        );

      case TrackingType.text:
        return TextTracker(onComplete: (text) => onComplete(text));

      case TrackingType.gps:
        // GPS will show a "Check In" button that verifies location
        return BooleanTracker(
          challenge: challenge,
          onComplete: (value) => onComplete(value),
          customLabel: 'Check In at Location',
          customIcon: Icons.location_on,
        );

      case TrackingType.camera:
        // Camera-only tracking (photo is the completion)
        return CameraTracker(onComplete: (photoPath) => onComplete(photoPath));

      case TrackingType.multiStep:
        return Center(child: Text("Multi-step coming soon"));
    }
  }
}

/// Small camera button that can be added to any tracker
class CameraProofButton extends StatelessWidget {
  final Function(String? photoPath)? onPhotoTaken;

  const CameraProofButton({super.key, this.onPhotoTaken});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        // TODO: Open camera
        onPhotoTaken?.call(null);
      },
      icon: const Icon(Icons.camera_alt, size: 18),
      label: const Text('Add Photo Proof'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey[600],
        side: BorderSide(color: Colors.grey[300]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
