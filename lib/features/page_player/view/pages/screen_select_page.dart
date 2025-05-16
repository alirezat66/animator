import 'package:animator/features/page_player/view_model/bloc/page_player_bloc.dart';
import 'package:animator/features/page_player/view_model/bloc/page_player_event.dart';
import 'package:animator/features/page_player/view_model/bloc/page_player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSelectionPage extends StatefulWidget {
  const ScreenSelectionPage({super.key});

  @override
  State<ScreenSelectionPage> createState() => _ScreenSelectionPageState();
}

class _ScreenSelectionPageState extends State<ScreenSelectionPage> {
  @override
  void initState() {
    context.read<PagePlayerBloc>().add(LoadPagePlayerEvent());
    super.initState();
  }

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
            Expanded(
              child: BlocBuilder<PagePlayerBloc, PagePlayerState>(
                builder: (context, state) {
                  return state is PagePlayerLoaded
                      ? ListView.builder(
                        itemCount: state.pages.length,
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 16,
                              ),
                            ),
                            onPressed: () {
                              // Navigate to the animated page player screen, passing the page model
                              Navigator.pushNamed(
                                context,
                                '/innerPage',
                                arguments: state.pages[index],
                              );
                            },
                            child: Text(
                              state.pages[index].screenId,
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        },
                      )
                      : SizedBox(
                        width: kToolbarHeight,
                        height: kToolbarHeight,
                        child: CircularProgressIndicator.adaptive(),
                      );
                },
              ),
            ),
            // Screen selection button

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
