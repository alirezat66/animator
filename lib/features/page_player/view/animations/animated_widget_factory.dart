import 'package:animator/features/page_player/view/animations/enhance_fader.dart';
import 'package:animator/features/page_player/model/data/item_model.dart';
import 'package:animator/features/page_player/view/animations/timeline_controller.dart';
import 'package:animator/features/page_player/view/widgets/concrete_widgets/error_placeholder_widget.dart';
import 'package:flutter/material.dart';

class AnimatedWidgetFactory {
  final Map<String, Function> _widgetBuilders = {};
  final Map<GlobalKey<EntranceFaderState>, String> _animationKeyMap = {};

  AnimatedWidgetFactory() {
    // Register default widget builders here if needed
  }

  void registerWidgetBuilder(String type, Function builder) {
    _widgetBuilders[type] = builder;
  }

  Widget buildAnimatedWidget(
    ItemModel itemData,
    BuildContext context,
    TimelineControllerState timelineController,
  ) {
    try {
      // Create a unique key for this animation
      final animKey = GlobalKey<EntranceFaderState>();

      // Register this animation with the timeline controller
      timelineController.registerAnimation(animKey);

      // Store the itemId for debugging
      _animationKeyMap[animKey] = itemData.itemId;

      // Get the base widget from the registered builder
      final widgetBuilder = _widgetBuilders[itemData.type];
      if (widgetBuilder == null) {
        return ErrorPlaceholderWidget(
          itemData: itemData,
          error: 'No builder for type: ${itemData.type}',
        );
      }

      // Build the base widget
      final baseWidget = widgetBuilder(itemData);

      // If there are no animations, just return the base widget
      if (itemData.animations == null) {
        return baseWidget;
      }

      // Create an EntranceFader widget with the animations from the item data
      return EntranceFader(
        key: animKey,
        appearAnimation: itemData.animations?.appear,
        dismissAnimation: itemData.animations?.dismiss,
        child: baseWidget,
      );
    } catch (e) {
      print('Error building animated widget for ${itemData.itemId}: $e');
      return ErrorPlaceholderWidget(itemData: itemData, error: e.toString());
    }
  }
}
