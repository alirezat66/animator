import 'package:animator/features/page_player/view/animations/animation_strategy.dart';
import 'package:flutter/material.dart';

class VerticalAppearanceAnimationStrategy implements AnimationStrategy {
  final bool isForward;
  final String direction;

  VerticalAppearanceAnimationStrategy({
    this.isForward = true,
    this.direction = 'up',
  });

  @override
  Widget buildAnimation(
    BuildContext context,
    AnimationController controller,
    Widget child,
    Offset offset,
  ) {
    // For appear animation, slide from bottom to center (or top to center)
    // For dismiss animation, we only want to fade without sliding
    if (isForward) {
      final startOffset =
          direction == 'up'
              ? const Offset(0.0, 1.0) // from bottom
              : const Offset(0.0, -1.0); // from top

      return SlideTransition(
        position: Tween<Offset>(
          begin: startOffset,
          end: const Offset(0.0, 0.0),
        ).animate(controller),
        child: FadeTransition(opacity: controller, child: child),
      );
    } else {
      // For dismissal, only fade out without any sliding
      return FadeTransition(opacity: controller, child: child);
    }
  }
}
