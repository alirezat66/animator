import 'package:flutter/material.dart';
import '../../model/data/item_model.dart';
import 'concrete_widgets/error_placeholder_widget.dart'; // Will create this next
import 'concrete_widgets/shape_widget.dart'; // Import ShapeWidget

typedef WidgetBuilder = Widget Function(ItemModel itemData);

class WidgetFactory {
  final Map<String, WidgetBuilder> _widgetRegistry = {};

  WidgetFactory() {
    // Register default widgets
    // registerWidget('text', (itemData) => TextWidget(itemData: itemData)); // Assuming TextWidget exists
    registerWidget('shape', (itemData) => ShapeWidget(itemData: itemData)); // Register ShapeWidget
    // registerWidget('image', (itemData) => ImageWidget(itemData: itemData)); // Assuming ImageWidget exists
  }

  void registerWidget(String type, WidgetBuilder builder) {
    _widgetRegistry[type] = builder;
  }

  Widget buildWidget(ItemModel itemData) {
    final builder = _widgetRegistry[itemData.type];
    if (builder != null) {
      try {
        return builder(itemData);
      } catch (e) {
        // Handle errors during widget building
        print('Error building widget of type ${itemData.type}: $e');
        return ErrorPlaceholderWidget(itemData: itemData, error: e.toString());
      }
    } else {
      // Handle unknown widget types
      print('Unknown widget type: ${itemData.type}');
      return ErrorPlaceholderWidget(itemData: itemData, error: 'Unknown type');
    }
  }
}