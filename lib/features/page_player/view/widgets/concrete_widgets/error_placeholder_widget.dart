import 'package:flutter/material.dart';
import '../../../model/data/item_model.dart';

class ErrorPlaceholderWidget extends StatelessWidget {
  final ItemModel itemData;
  final String error;

  const ErrorPlaceholderWidget({
    Key? key,
    required this.itemData,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: itemData.layout.size.width,
      height: itemData.layout.size.height,
      color: Colors.red.withOpacity(0.3),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.red[900]),
              Text(
                'Error rendering widget:',
                style: TextStyle(color: Colors.red[900], fontSize: 12),
                textAlign: TextAlign.center,
              ),
              Text(
                'ID: ${itemData.itemId}',
                style: TextStyle(color: Colors.red[900], fontSize: 10),
                textAlign: TextAlign.center,
              ),
              Text(
                'Type: ${itemData.type}',
                style: TextStyle(color: Colors.red[900], fontSize: 10),
                textAlign: TextAlign.center,
              ),
              // Optionally display the error message itself
              // Text(
              //   'Error: $error',
              //   style: TextStyle(color: Colors.red[900], fontSize: 10),
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}