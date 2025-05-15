import 'package:flutter/material.dart';
import '../../../model/data/item_model.dart'; // Import ItemModel and ImageContentModel
import './error_placeholder_widget.dart'; // Import ErrorPlaceholderWidget

class ImageWidget extends StatelessWidget {
  final ItemModel itemData;

  const ImageWidget({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    // Apply layout properties (position, size, angle) - will be wrapped by parent
    // Apply style properties (opacity, fill, stroke, shadow, blur)

    final style = itemData.style;
    final layout = itemData.layout;
    final content = itemData.content; // This should be ImageContentModel

    // Assuming content is a Map that can be parsed into ImageContentModel
    ImageContentModel? imageContent;
    if (content is Map<String, dynamic>) {
      try {
        imageContent = ImageContentModel.fromJson(content);
      } catch (e) {
        print(
          'Error parsing ImageContentModel for item ${itemData.itemId}: $e',
        );
        // Return an error placeholder if content is malformed
        return ErrorPlaceholderWidget(
          itemData: itemData,
          error: 'Malformed image content',
        );
      }
    } else {
      // Return an error placeholder if content is not a Map
      return ErrorPlaceholderWidget(
        itemData: itemData,
        error: 'Invalid image content type',
      );
    }

    // Basic image rendering
    Widget imageWidget = Image.network(
      imageContent.src, // Use a placeholder image or handle null src
      width: layout.size.width,
      height: layout.size.height,
      fit: BoxFit.contain, // Or BoxFit.fill, BoxFit.cover based on requirements
      // Add other Image properties as needed
    );

    // Apply opacity
    if (style.opacity < 1.0) {
      imageWidget = Opacity(opacity: style.opacity, child: imageWidget);
    }

    // Apply style properties like border, shadow, blur if needed, similar to ShapeWidget.
    // For simplicity, we'll skip these for now.

    // The positioning, size, and rotation will be handled by the parent widget (DynamicScreen)
    // using Stack and Positioned/Transform.rotate based on itemData.layout.

    return imageWidget;
  }
}

// Assuming ImageContentModel is defined in item_model.dart
// If not, it should be moved to its own file like TextStyleModel.
// For now, we'll assume it's accessible via the item_model.dart import.
