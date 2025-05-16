import 'package:animator/core/utils/color_ext.dart';
import 'package:flutter/material.dart';
import '../../../model/data/item_model.dart';

class TextWidget extends StatelessWidget {
  final ItemModel itemData;

  const TextWidget({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    // Apply layout properties (position, size, angle) - will be wrapped by parent
    // Apply style properties (opacity, fill, stroke, shadow, blur)

    final textStyle = itemData.textStyle;
    final style = itemData.style;

    // Basic text styling
    TextStyle flutterTextStyle = TextStyle(
      fontFamily: textStyle?.fontFamily,
      fontSize: textStyle?.size?.toDouble() ?? 14.0,
      fontWeight: _parseFontWeight(textStyle?.weight),
      color:
          style.fill.isFill ? style.fill.color.toColor() : Colors.transparent,
      // Add other text style properties as needed (alignment, verticalAlignment, etc.)
    );

    // Apply stroke (outline) - requires a package or custom painting
    // For simplicity, we'll skip stroke for now or use a basic approach if possible.

    // Apply shadow - requires a package or custom painting
    // For simplicity, we'll skip shadow for now.

    // Apply blur - requires a package or custom painting
    // For simplicity, we'll skip blur for now.

    Widget textWidget = Text(
      itemData.content as String, // Assuming content is String for text
      style: flutterTextStyle,
      textAlign: _parseTextAlign(textStyle?.alignment),
      // Add other Text properties as needed (maxLines, overflow, etc.)
    );

    // Apply opacity
    if (style.opacity < 1.0) {
      textWidget = Opacity(opacity: style.opacity, child: textWidget);
    }

    // The positioning, size, and rotation will be handled by the parent widget (DynamicScreen)
    // using Stack and Positioned/Transform.rotate based on itemData.layout.

    // Wrap with Container to apply width and height from layout
    return Container(
      width: itemData.layout.size.width.toDouble(),
      height: itemData.layout.size.height.toDouble(),
      child: textWidget,
    );
  }

  FontWeight? _parseFontWeight(String? weight) {
    if (weight == null) return null;
    switch (weight.toLowerCase()) {
      case 'w100':
        return FontWeight.w100;
      case 'w200':
        return FontWeight.w200;
      case 'w300':
        return FontWeight.w300;
      case 'w400':
        return FontWeight.w400;
      case 'w500':
        return FontWeight.w500;
      case 'w600':
        return FontWeight.w600;
      case 'w700':
        return FontWeight.w700;
      case 'w800':
        return FontWeight.w800;
      case 'w900':
        return FontWeight.w900;
      default:
        return null;
    }
  }

  TextAlign? _parseTextAlign(String? alignment) {
    if (alignment == null) return null;
    switch (alignment.toLowerCase()) {
      case 'left':
        return TextAlign.left;
      case 'right':
        return TextAlign.right;
      case 'center':
        return TextAlign.center;
      case 'justify':
        return TextAlign.justify;
      case 'start':
        return TextAlign.start;
      case 'end':
        return TextAlign.end;
      default:
        return null;
    }
  }
}
