/* import 'package:animator/core/utils/color_ext.dart';
import 'package:animator/features/page_player/view/animations/animated_widget_factory.dart';
import 'package:animator/features/page_player/view/animations/timeline_controller.dart';
import 'package:animator/features/page_player/view/widgets/widget_factory.dart';
import 'package:animator/features/page_player/view_model/bloc/page_player_bloc.dart';
import 'package:animator/features/page_player/view_model/bloc/page_player_event.dart';
import 'package:animator/features/page_player/view_model/bloc/page_player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AnimatedPagePlayerScreen extends StatefulWidget {
  const AnimatedPagePlayerScreen({super.key});

  @override
  State<AnimatedPagePlayerScreen> createState() =>
      _AnimatedPagePlayerScreenState();
}

class _AnimatedPagePlayerScreenState extends State<AnimatedPagePlayerScreen> {
  final _timelineControllerKey = GlobalKey<TimelineControllerState>();
  late AnimatedWidgetFactory _animatedWidgetFactory;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimatedWidgetFactory
    _animatedWidgetFactory = AnimatedWidgetFactory();

    // Register widget builders with the factory - using the existing WidgetFactory
    final widgetFactory = GetIt.I<WidgetFactory>();
    _animatedWidgetFactory.registerWidgetBuilder(
      'text',
      widgetFactory.buildWidget,
    );
    _animatedWidgetFactory.registerWidgetBuilder(
      'shape',
      widgetFactory.buildWidget,
    );
    _animatedWidgetFactory.registerWidgetBuilder(
      'image',
      widgetFactory.buildWidget,
    );

    // Trigger the event to load the page data when the screen is created
    context.read<PagePlayerBloc>().add(const LoadPagePlayerEvent());

    // Start the animation after a short delay to ensure everything is loaded
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted && _timelineControllerKey.currentState != null) {
        _timelineControllerKey.currentState!.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PagePlayerBloc, PagePlayerState>(
        builder: (context, state) {
          if (state is PagePlayerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PagePlayerLoaded) {
            final page = state.page;

            // Determine background color
            Color backgroundColor = Colors.white; // Default background
            try {
              backgroundColor = page.background.color.toColor();
            } catch (e) {
              print(
                'Error parsing background color: ${page.background.color}, error: $e',
              );
              // Keep default white background on error
            }

            return TimelineController(
              key: _timelineControllerKey,
              totalDurationMs: 7000, // 7 seconds total duration
              onCompleted: () {
                print('Timeline animation completed');
              },
              child: Container(
                color: backgroundColor,
                child: Builder(
                  builder: (context) {
                    // Get the timeline controller only after it's built
                    TimelineControllerState? timelineController =
                        _timelineControllerKey.currentState;
                    final widgetFactory = GetIt.I<WidgetFactory>();

                    return Stack(
                      children:
                          page.items.map((itemData) {
                            // Build the widget with animations using our factory
                            final animatedWidget =
                                timelineController != null
                                    ? _animatedWidgetFactory
                                        .buildAnimatedWidget(
                                          itemData,
                                          context,
                                          timelineController,
                                        )
                                    : widgetFactory.buildWidget(
                                      itemData,
                                    ); // Fallback to regular widget if controller isn't ready

                            // Apply positioning and rotation based on layout
                            return Positioned(
                              left:
                                  itemData.layout.position.axisXAlignmentType ==
                                          'left'
                                      ? itemData.layout.position.xPosition
                                      : null,
                              right:
                                  itemData.layout.position.axisXAlignmentType ==
                                          'right'
                                      ? itemData.layout.position.xPosition
                                      : null,
                              top:
                                  itemData.layout.position.axisYAlignmentType ==
                                          'top'
                                      ? itemData.layout.position.yPosition
                                      : null,
                              bottom:
                                  itemData.layout.position.axisYAlignmentType ==
                                          'bottom'
                                      ? itemData.layout.position.yPosition
                                      : null,
                              width: itemData.layout.size.width,
                              height: itemData.layout.size.height,
                              child: Transform.rotate(
                                angle:
                                    itemData.layout.angle *
                                    (3.1415926535 /
                                        180), // Convert degrees to radians
                                child: animatedWidget,
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            );
          } else if (state is PagePlayerError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          // Initial state or any other unhandled state
          return const Center(child: Text('Press button to load page'));
        },
      ),
      // Remove the floating action button - timeline starts automatically
    );
  }
}
 */