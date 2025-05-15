import 'package:animator/features/page_player/view/animations/animation_strategy.dart';
import 'package:flutter/material.dart';

class SimpleFadeAnimationStrategy implements AnimationStrategy {
  @override
  Widget buildAnimation(
    BuildContext context,
    AnimationController controller,
    Widget child,
    Offset offset,
  ) {
    return FadeTransition(opacity: controller, child: child);
  }
}
