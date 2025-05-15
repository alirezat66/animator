import 'package:animator/features/page_player/model/data/item_model.dart';
import 'package:animator/features/page_player/view/animations/animation_strategy.dart';
import 'package:animator/features/page_player/view/animations/strategy/animation_factory.dart';
import 'package:animator/features/page_player/view/animations/strategy/no_animation_strategy.dart';
import 'package:animator/features/page_player/view/animations/strategy/simple_fade_animation_strategy.dart';
import 'package:flutter/material.dart';

enum AnimationType { none, appear, dismiss }

class EntranceFaderState extends State<EntranceFader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationType _currentAnimationType;
  bool _isVisible = false;
  bool _isAnimating = false;
  late AnimationStrategy _appearStrategy;
  late AnimationStrategy _dismissStrategy;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400), // Default duration
    );

    // Initialize visibility based on whether there's an appearAnimation
    _isVisible = widget.appearAnimation == null;
    _currentAnimationType = AnimationType.none;

    // Create animation strategies based on animation types
    _appearStrategy =
        widget.appearAnimation != null
            ? AnimationStrategyFactory.getStrategy(
              widget.appearAnimation!.type,
              widget.appearAnimation!.direction,
              true,
            ) // true = forward animation
            : NoAnimationStrategy();

    _dismissStrategy =
        widget.dismissAnimation != null
            ? AnimationStrategyFactory.getStrategy(
              widget.dismissAnimation!.type,
              widget.dismissAnimation!.direction,
              false,
            ) // false = reverse animation
            : SimpleFadeAnimationStrategy(); // Default to fade for dismiss

    if (_isVisible) {
      _controller.value = 1.0; // Fully visible if no appear animation
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Called by the timeline controller to update animation state based on current time
  void updateWithTime(int currentTimeMs) {
    // Handle appearance animation
    if (widget.appearAnimation != null &&
        currentTimeMs >= widget.appearAnimation!.timesheet.start &&
        !_isVisible &&
        _currentAnimationType != AnimationType.appear) {
      _appear();
    }

    // Handle dismissal animation
    if (widget.dismissAnimation != null &&
        currentTimeMs >= widget.dismissAnimation!.timesheet.start &&
        _isVisible &&
        _currentAnimationType != AnimationType.dismiss) {
      _dismiss();
    }
  }

  /// Starts the appearance animation
  void _appear() {
    if (_isAnimating) return;

    _currentAnimationType = AnimationType.appear;
    _isAnimating = true;
    setState(() {
      _isVisible = true;
    });

    _controller.duration = Duration(
      milliseconds: widget.appearAnimation!.timesheet.duration,
    );

    _controller.forward(from: 0.0).then((_) {
      _isAnimating = false;
    });
  }

  /// Starts the dismissal animation
  void _dismiss() {
    if (_isAnimating) return;

    _currentAnimationType = AnimationType.dismiss;
    _isAnimating = true;

    _controller.duration = Duration(
      milliseconds: widget.dismissAnimation!.timesheet.duration,
    );

    _controller.reverse(from: 1.0).then((_) {
      if (mounted) {
        setState(() {
          _isVisible = false;
          _isAnimating = false;
        });
      }
    });
  }

  /// Resets the animation state for timeline replay
  void reset() {
    _currentAnimationType = AnimationType.none;
    _isAnimating = false;

    setState(() {
      _isVisible = widget.appearAnimation == null;

      if (_isVisible) {
        _controller.value = 1.0;
      } else {
        _controller.value = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible && !_isAnimating) {
      return const SizedBox.shrink(); // Hide widget completely when not visible
    }

    // Use the appropriate animation strategy based on the current animation type
    final strategy =
        _currentAnimationType == AnimationType.appear
            ? _appearStrategy
            : _dismissStrategy;

    return strategy.buildAnimation(
      context,
      _controller,
      widget.child,
      widget.offset,
    );
  }
}

class EntranceFader extends StatefulWidget {
  /// Child to be animated
  final Widget child;

  /// Appearance animation details
  final AnimationDetailModel? appearAnimation;

  /// Dismissal animation details
  final AnimationDetailModel? dismissAnimation;

  /// Starting offset for animations
  final Offset offset;

  const EntranceFader({
    super.key,
    required this.child,
    this.appearAnimation,
    this.dismissAnimation,
    this.offset = const Offset(0.0, 32.0),
  });

  @override
  EntranceFaderState createState() => EntranceFaderState();
}
