import 'package:animator/features/page_player/view/animations/animation_strategy.dart';

import 'package:animator/features/page_player/view/animations/strategy/horizontal_appearance_animation_strategy.dart';
import 'package:animator/features/page_player/view/animations/strategy/no_animation_strategy.dart';
import 'package:animator/features/page_player/view/animations/strategy/simple_fade_animation_strategy.dart';
import 'package:animator/features/page_player/view/animations/strategy/vertical_appearance_animation_strategy.dart';

class AnimationStrategyFactory {
  static AnimationStrategy getStrategy(
    String type,
    String? direction,
    bool isForward,
  ) {
    switch (type) {
      case 'appear':
        if (direction == 'left' || direction == 'right') {
          return HorizontalAppearanceAnimationStrategy(isForward: isForward);
        } else {
          return VerticalAppearanceAnimationStrategy(
            isForward: isForward,
            direction: direction ?? 'up',
          );
        }
      case 'fadeout':
      case 'fade':
        return SimpleFadeAnimationStrategy();
      default:
        return NoAnimationStrategy();
    }
  }
}
