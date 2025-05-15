import 'package:animator/features/page_player/view/animations/animation_strategy.dart';
import 'package:flutter/material.dart';

class FadeOutAnimationStrategy implements AnimationStrategy {
  final String? direction;

  FadeOutAnimationStrategy({this.direction});

  @override
  Widget buildAnimation(
    BuildContext context,
    AnimationController controller,
    Widget child,
    Offset offset,
  ) {
    // For fadeout, we don't want any slide animation, just fading
    return FadeTransition(opacity: controller, child: child);
  }
}
