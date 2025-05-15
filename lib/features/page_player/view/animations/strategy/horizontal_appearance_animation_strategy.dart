import 'package:animator/features/page_player/view/animations/animation_strategy.dart';
import 'package:flutter/material.dart';

class HorizontalAppearanceAnimationStrategy implements AnimationStrategy {
  final bool isForward;

  HorizontalAppearanceAnimationStrategy({this.isForward = true});

  @override
  Widget buildAnimation(
    BuildContext context,
    AnimationController controller,
    Widget child,
    Offset offset,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(controller),
      child: FadeTransition(opacity: controller, child: child),
    );
  }
}
