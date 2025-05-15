import 'package:flutter/material.dart';

abstract class AnimationStrategy {
  Widget buildAnimation(
    BuildContext context,
    AnimationController controller,
    Widget child,
    Offset offset,
  );
}
