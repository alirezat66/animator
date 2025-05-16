import 'package:animator/core/utils/color_ext.dart';
import 'package:animator/features/page_player/model/data/page_model.dart';
import 'package:flutter/material.dart';
import '../widgets/widget_factory.dart';
import 'package:get_it/get_it.dart';

class PagePlayerScreen extends StatefulWidget {
  final PageModel page;
  const PagePlayerScreen({super.key, required this.page});

  @override
  State<PagePlayerScreen> createState() => _PagePlayerScreenState();
}

class _PagePlayerScreenState extends State<PagePlayerScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the event to load the page data when the screen is created
  }

  @override
  Widget build(BuildContext context) {
    final widgetFactory = GetIt.I<WidgetFactory>();

    return Scaffold(
      // appBar: AppBar(title: const Text('Dynamic Page')), // Optional AppBar
      body: Container(
        color: widget.page.background.color.toColor(),
        // Background image could be added here if needed
        child: Stack(
          children:
              widget.page.items.map((itemData) {
                // Build each widget using the factory
                final itemWidget = widgetFactory.buildWidget(itemData);

                // Apply positioning and rotation based on layout
                // Note: This is a simplified approach. More complex layouts
                // might require custom layout widgets or calculations.
                return Positioned(
                  left:
                      itemData.layout.position.axisXAlignmentType == 'left'
                          ? itemData.layout.position.xPosition
                          : null,
                  right:
                      itemData.layout.position.axisXAlignmentType == 'right'
                          ? itemData.layout.position.xPosition
                          : null,
                  top:
                      itemData.layout.position.axisYAlignmentType == 'top'
                          ? itemData.layout.position.yPosition
                          : null,
                  bottom:
                      itemData.layout.position.axisYAlignmentType == 'bottom'
                          ? itemData.layout.position.yPosition
                          : null,
                  width: itemData.layout.size.width,
                  height: itemData.layout.size.height,
                  child: Transform.rotate(
                    angle:
                        itemData.layout.angle *
                        (3.1415926535 / 180), // Convert degrees to radians
                    child: itemWidget,
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
