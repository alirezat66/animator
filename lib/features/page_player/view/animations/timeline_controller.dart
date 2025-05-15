import 'package:animator/features/page_player/view/animations/enhance_fader.dart';
import 'package:flutter/material.dart';

class TimelineController extends StatefulWidget {
  final Widget child;
  final int totalDurationMs;
  final VoidCallback? onCompleted;
  final Widget Function(BuildContext, VoidCallback, VoidCallback)?
  controlsBuilder;

  const TimelineController({
    Key? key,
    required this.child,
    this.totalDurationMs = 7000, // Default to 7 seconds
    this.onCompleted,
    this.controlsBuilder,
  }) : super(key: key);

  @override
  TimelineControllerState createState() => TimelineControllerState();

  // Helper method to access the controller from anywhere in the widget tree
  static TimelineControllerState of(BuildContext context) {
    final state = context.findAncestorStateOfType<TimelineControllerState>();
    if (state == null) {
      throw FlutterError(
        'TimelineController.of() called with a context that does not contain a TimelineController.',
      );
    }
    return state;
  }
}

class TimelineControllerState extends State<TimelineController>
    with TickerProviderStateMixin {
  late AnimationController _timeController;
  final List<GlobalKey<EntranceFaderState>> _animationKeys = [];
  bool _isCompleted = false;
  bool _isPlaying = false;
  int _currentTimeMs = 0;

  // Register animation keys with the controller
  void registerAnimation(GlobalKey<EntranceFaderState> key) {
    if (!_animationKeys.contains(key)) {
      _animationKeys.add(key);
    }
  }

  @override
  void initState() {
    super.initState();
    _timeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.totalDurationMs),
    );

    _timeController.addListener(_updateAnimations);

    _timeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isCompleted = true;
          _isPlaying = false;
        });

        if (widget.onCompleted != null) {
          widget.onCompleted!();
        }
      }
    });
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  void _updateAnimations() {
    // Calculate current time in milliseconds
    _currentTimeMs = (_timeController.value * widget.totalDurationMs).round();

    // Print debug info
    if (_currentTimeMs % 500 == 0) {
      // Only print every 500ms to avoid flooding
      print('Timeline at time: $_currentTimeMs ms');
    }

    // Update all registered animations
    for (var key in _animationKeys) {
      if (key.currentState != null) {
        key.currentState!.updateWithTime(_currentTimeMs);
      }
    }
  }

  // Start the timeline animation
  void play() {
    if (_isPlaying) return;

    setState(() {
      _isCompleted = false;
      _isPlaying = true;
    });
    _timeController.forward(from: 0.0);
  }

  // Pause the timeline animation
  void pause() {
    if (!_isPlaying) return;

    setState(() {
      _isPlaying = false;
    });
    _timeController.stop();
  }

  // Reset the timeline
  void reset() {
    _timeController.reset();
    _currentTimeMs = 0;

    setState(() {
      _isCompleted = false;
      _isPlaying = false;
    });

    // Reset all animations
    for (var key in _animationKeys) {
      if (key.currentState != null) {
        key.currentState!.reset();
      }
    }
  }

  // Get the current time in milliseconds
  int getCurrentTimeMs() {
    return _currentTimeMs;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isCompleted)
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                // Exit logic - go back to the main selection page
                Navigator.of(context).pop();
              },
              child: const Text('Exit'),
            ),
          ),
      ],
    );
  }
}
