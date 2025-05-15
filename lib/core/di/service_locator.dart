import 'package:get_it/get_it.dart';
import '../../features/page_player/model/repository/page_local_datasource.dart';
import '../../features/page_player/model/repository/page_repository.dart';
import '../../features/page_player/view_model/bloc/page_player_bloc.dart';
import '../../features/page_player/view/widgets/widget_factory.dart';
import '../../features/page_player/view/widgets/concrete_widgets/text_widget.dart';
import '../../features/page_player/view/widgets/concrete_widgets/shape_widget.dart';
import '../../features/page_player/view/widgets/concrete_widgets/image_widget.dart';


final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Feature: Page Player

  // Model Layer
  sl.registerLazySingleton<PageLocalDataSource>(
      () => PageLocalDataSourceImpl());
  sl.registerLazySingleton<PageRepository>(
      () => PageRepository(localDataSource: sl()));

  // ViewModel Layer
  sl.registerFactory(() => PagePlayerBloc(pageRepository: sl()));

  // View Layer
  final widgetFactory = WidgetFactory();
  widgetFactory.registerWidget('text', (data) => TextWidget(itemData: data));
  widgetFactory.registerWidget('shape', (data) => ShapeWidget(itemData: data));
  widgetFactory.registerWidget('image', (data) => ImageWidget(itemData: data));
  // Register ErrorPlaceholderWidget as a fallback builder if needed,
  // although it's primarily used internally by WidgetFactory.
  // widgetFactory.registerWidget('error', (data) => ErrorPlaceholderWidget(itemData: data, error: ''));

  sl.registerSingleton<WidgetFactory>(widgetFactory);
}