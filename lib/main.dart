import 'package:animator/features/page_player/model/data/page_model.dart';
import 'package:animator/features/page_player/view/pages/page_player_screen.dart';
import 'package:animator/features/page_player/view/pages/screen_select_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart'; // Import GetIt setup
import 'features/page_player/view_model/bloc/page_player_bloc.dart'; // Import PagePlayerBloc
import 'features/page_player/model/repository/page_repository.dart'; // Import PageRepository (needed for BLoC creation before GetIt is fully set up)
import 'features/page_player/model/repository/page_local_datasource.dart'; // Import PageLocalDataSource (needed for Repository creation before GetIt is fully set up)

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for asset loading
  await setupServiceLocator(); // Initialize GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => PagePlayerBloc(
                pageRepository: PageRepository(
                  localDataSource: PageLocalDataSourceImpl(),
                ),
              ),
        ),
      ],
      child: MaterialApp(
        title: 'Page Animator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(
              builder: (_) => const ScreenSelectionPage(),
            );
          } else if (settings.name == '/innerPage') {
            final args = settings.arguments as PageModel;
            return MaterialPageRoute(
              builder: (_) => PagePlayerScreen(page: args),
            );
          }
          return null; // Unknown route
        },
      ),
    );
  }
}

// Remove the old MyHomePage widget as it's no longer needed
