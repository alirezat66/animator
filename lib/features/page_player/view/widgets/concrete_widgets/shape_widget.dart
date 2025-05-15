import 'package:animator/core/utils/color_ext.dart';
import 'package:flutter/material.dart';
import '../../../model/data/item_model.dart';

class ShapeWidget extends StatelessWidget {
  final ItemModel itemData;

  const ShapeWidget({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    // Apply layout properties (position, size, angle) - will be wrapped by parent
    // Apply style properties (opacity, fill, stroke, shadow, blur)

    final style = itemData.style;
    final layout = itemData.layout;

    // Basic shape rendering using Container
    Widget shapeWidget = Container(
      width: layout.size.width,
      height: layout.size.height,
      decoration: BoxDecoration(
        shape: itemData.content == 'circle' ? BoxShape.circle : BoxShape.rectangle,
        color: style.fill.isFill ? style.fill.color.toColor() : Colors.transparent,
        // Add border (stroke) if hasStroke is true
        border: style.stroke.hasStroke
            ? Border.all(
                color: style.stroke.color.toColor(),
                width: style.stroke.weight,
              )
            : null,
        // Add shadow if hasShadow is true
        boxShadow: style.shadow.hasShadow
            ? [
                BoxShadow(
                  color: style.shadow.color.toColor().withOpacity(style.shadow.opacity),
                  blurRadius: style.shadow.blur,
                  offset: Offset(style.shadow.offset.x, style.shadow.offset.y),
                ),
              ]
            : null,
        // Shape type is determined by itemData.content
      ),
    );

    // Apply opacity
    if (style.opacity < 1.0) {
      shapeWidget = Opacity(
        opacity: style.opacity,
        child: shapeWidget,
      );
    }

    // Apply blur - requires a package or custom painting
    // For simplicity, we'll skip blur for now.

    // The positioning, size, and rotation will be handled by the parent widget (DynamicScreen)
    // using Stack and Positioned/Transform.rotate based on itemData.layout.

    return shapeWidget;
  }
}