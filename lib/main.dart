import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart'; // Import GetIt setup
import 'features/page_player/view_model/bloc/page_player_bloc.dart'; // Import PagePlayerBloc
import 'features/page_player/view/pages/page_player_screen.dart'; // Import PagePlayerScreen
import 'features/page_player/model/repository/page_repository.dart'; // Import PageRepository (needed for BLoC creation before GetIt is fully set up)
import 'features/page_player/model/repository/page_local_datasource.dart'; // Import PageLocalDataSource (needed for Repository creation before GetIt is fully set up)


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for asset loading
  await setupServiceLocator(); // Initialize GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( // Use MultiBlocProvider if more BLoCs are added later
      providers: [
        BlocProvider(
          create: (context) => PagePlayerBloc(
             // Manually create dependencies here before GetIt is fully configured for the BLoC
             // In a real app, you'd get this from GetIt: GetIt.I<PageRepository>()
             // For now, manually create the repository and datasource
             pageRepository: PageRepository(
               localDataSource: PageLocalDataSourceImpl(),
             ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true, // Use Material 3 features
        ),
        home: const PagePlayerScreen(), // Set PagePlayerScreen as the home page
      ),
    );
  }
}

// Remove the old MyHomePage widget as it's no longer needed


