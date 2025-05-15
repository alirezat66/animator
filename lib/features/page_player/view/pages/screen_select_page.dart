import 'package:flutter/material.dart';

class ScreenSelectionPage extends StatelessWidget {
  const ScreenSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select a Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title and description
            const Text(
              'Available Screens',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select a screen to view its animation',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),

            // Screen selection button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              onPressed: () {
                // Navigate to the animated page player screen
                Navigator.pushNamed(context, '/screen1');
              },
              child: const Text('Screen 1', style: TextStyle(fontSize: 18)),
            ),

            // Add more buttons for additional screens as needed
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                // Use a disabled style for screens that don't exist yet
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.grey.shade700,
              ),
              onPressed: null, // Disabled for now
              child: const Text(
                'Screen 2 (Coming Soon)',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
