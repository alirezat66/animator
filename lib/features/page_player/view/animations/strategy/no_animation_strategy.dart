import 'package:animator/features/page_player/view/animations/animation_strategy.dart';
import 'package:flutter/material.dart';

class NoAnimationStrategy implements AnimationStrategy {
  @override
  Widget buildAnimation(
    BuildContext context,
    AnimationController controller,
    Widget child,
    Offset offset,
  ) {
    return child; // No animation, just return the child
  }
}
