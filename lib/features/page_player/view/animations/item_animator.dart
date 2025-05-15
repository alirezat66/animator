import 'package:flutter/material.dart';
import '../../model/data/item_model.dart';

class ItemAnimator extends StatelessWidget {
  final ItemModel itemData;
  final int currentTime;
  final Widget child;

  const ItemAnimator({
    super.key,
    required this.itemData,
    required this.currentTime,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final appearAnimation = itemData.animations?.appear;
    final dismissAnimation = itemData.animations?.dismiss;

    // Define animation times, handling cases where animations are null
    final int appearStartTime = appearAnimation?.timesheet.start ?? 0;
    final int appearDuration = appearAnimation?.timesheet.duration ?? 0;
    final int appearEndTime = appearStartTime + appearDuration;

    final int dismissStartTime = dismissAnimation?.timesheet.start ?? 0;
    final int dismissDuration = dismissAnimation?.timesheet.duration ?? 0;
    final int dismissEndTime = dismissStartTime + dismissDuration;

    // Determine visibility based on current time and timesheets
    bool isVisible = false;
    double opacity = 1.0; // Default to fully visible

    if (appearAnimation == null && dismissAnimation == null) {
      // Case 1: No animations - always visible
      isVisible = true;
      opacity = 1.0;
    } else if (appearAnimation != null && dismissAnimation == null) {
      // Case 2: Only appear animation - visible from appear start onwards
      if (currentTime >= appearStartTime) {
        isVisible = true;
        if (currentTime < appearEndTime) {
          // During appear animation (fade in)
          final progress = (currentTime - appearStartTime) / appearDuration;
          if (appearAnimation.category == 'fade' && appearAnimation.type == 'fadeIn') {
            opacity = progress.clamp(0.0, 1.0);
          } else {
             opacity = 1.0; // Assume full opacity for non-fade appear animations during animation
          }
        } else {
          // After appear animation ends
          opacity = 1.0;
        }
      } else {
        // Before appear animation starts
        isVisible = false;
        opacity = 0.0;
      }
    } else if (appearAnimation == null && dismissAnimation != null) {
      // Case 3: Only dismiss animation - visible until dismiss end
      if (currentTime <= dismissEndTime) {
        isVisible = true;
        if (currentTime >= dismissStartTime) {
          // During dismiss animation (fade out)
          final progress = (currentTime - dismissStartTime) / dismissDuration;
          if (dismissAnimation.category == 'fade' && dismissAnimation.type == 'fadeOut') {
            opacity = (1.0 - progress).clamp(0.0, 1.0);
          } else {
             opacity = 1.0; // Assume full opacity for non-fade dismiss animations during animation
          }
        } else {
          // Before dismiss animation starts
          opacity = 1.0;
        }
      } else {
        // After dismiss animation ends
        isVisible = false;
        opacity = 0.0;
      }
    } else if (appearAnimation != null && dismissAnimation != null) {
      // Case 4: Both appear and dismiss animations - visible between appear start and dismiss end
      if (currentTime >= appearStartTime && currentTime <= dismissEndTime) {
        isVisible = true;
        if (currentTime < appearEndTime) {
          // During appear animation (fade in)
          final progress = (currentTime - appearStartTime) / appearDuration;
          if (appearAnimation.category == 'fade' && appearAnimation.type == 'fadeIn') {
            opacity = progress.clamp(0.0, 1.0);
          } else {
             opacity = 1.0; // Assume full opacity for non-fade appear animations during animation
          }
        } else if (currentTime >= appearEndTime && currentTime < dismissStartTime) {
          // Between appear and dismiss animations
          opacity = 1.0;
        } else if (currentTime >= dismissStartTime && currentTime <= dismissEndTime) {
          // During dismiss animation (fade out)
          final progress = (currentTime - dismissStartTime) / dismissDuration;
          if (dismissAnimation.category == 'fade' && dismissAnimation.type == 'fadeOut') {
            opacity = (1.0 - progress).clamp(0.0, 1.0);
          } else {
             opacity = 1.0; // Assume full opacity for non-fade dismiss animations during animation
          }
        }
      } else {
        // Before appear or after dismiss
        isVisible = false;
        opacity = 0.0;
      }
    }

    if (!isVisible) {
      return const SizedBox.shrink();
    }

    // Apply opacity for fade animations
    if ((appearAnimation != null && appearAnimation.category == 'fade') ||
        (dismissAnimation != null && dismissAnimation.category == 'fade')) {
       return Opacity(
         opacity: opacity,
         child: child,
       );
    }

    // Return child directly if no relevant animations or not a fade animation
    return child;
  }
}