import 'package:animator/core/utils/color_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/bloc/page_player_bloc.dart';
import '../../view_model/bloc/page_player_state.dart';
import '../../view_model/bloc/page_player_event.dart'; // Import LoadPagePlayerEvent
import '../widgets/widget_factory.dart';
import 'package:get_it/get_it.dart';

class PagePlayerScreen extends StatefulWidget {
  const PagePlayerScreen({super.key});

  @override
  State<PagePlayerScreen> createState() => _PagePlayerScreenState();
}

class _PagePlayerScreenState extends State<PagePlayerScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the event to load the page data when the screen is created
    context.read<PagePlayerBloc>().add(const LoadPagePlayerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Dynamic Page')), // Optional AppBar
      body: BlocBuilder<PagePlayerBloc, PagePlayerState>(
        builder: (context, state) {
          if (state is PagePlayerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PagePlayerLoaded) {
            final page = state.page;
            final widgetFactory = GetIt.I<WidgetFactory>();

            // Determine background color
            Color backgroundColor = Colors.white; // Default background
            try {
               backgroundColor = page.background.color.toColor();
            } catch (e) {
              print('Error parsing background color: ${page.background.color}, error: $e');
              // Keep default white background on error
            }


            return Container(
              color: backgroundColor,
              // Background image could be added here if needed
              child: Stack(
                children: page.items.map((itemData) {
                  // Build each widget using the factory
                  final itemWidget = widgetFactory.buildWidget(itemData);

                  // Apply positioning and rotation based on layout
                  // Note: This is a simplified approach. More complex layouts
                  // might require custom layout widgets or calculations.
                  return Positioned(
                    left: itemData.layout.position.axisXAlignmentType == 'left' ? itemData.layout.position.xPosition : null,
                    right: itemData.layout.position.axisXAlignmentType == 'right' ? itemData.layout.position.xPosition : null,
                    top: itemData.layout.position.axisYAlignmentType == 'top' ? itemData.layout.position.yPosition : null,
                    bottom: itemData.layout.position.axisYAlignmentType == 'bottom' ? itemData.layout.position.yPosition : null,
                    width: itemData.layout.size.width,
                    height: itemData.layout.size.height,
                    child: Transform.rotate(
                      angle: itemData.layout.angle * (3.1415926535 / 180), // Convert degrees to radians
                      child: itemWidget,
                    ),
                  );
                }).toList(),
              ),
            );
          } else if (state is PagePlayerError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          // Initial state or any other unhandled state
          return const Center(child: Text('Press button to load page')); // Or a loading indicator
        },
      ),
      // Optional FloatingActionButton to reload or trigger other events
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context.read<PagePlayerBloc>().add(const LoadPagePlayerEvent());
      //   },
      //   tooltip: 'Reload Page',
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}