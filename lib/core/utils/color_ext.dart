import 'package:flutter/material.dart';

extension ColorExtension on String {
  Color toColor() {
    // Add the '#' prefix and parse as a hex integer.
    final hexInt = int.parse('FF$this', radix: 16);
    return Color(hexInt);
  }
}

/// Parses a hex color string (e.g., "FFFFFF", "000000") into a Flutter Color.
/// Assumes the input string does NOT include a '#' prefix.
