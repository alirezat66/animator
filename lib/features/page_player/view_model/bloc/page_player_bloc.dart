import 'package:bloc/bloc.dart';
import '../../model/repository/page_repository.dart';
import 'page_player_event.dart';
import 'page_player_state.dart';

class PagePlayerBloc extends Bloc<PagePlayerEvent, PagePlayerState> {
  final PageRepository pageRepository;

  PagePlayerBloc({required this.pageRepository}) : super(const PagePlayerInitial()) {
    on<LoadPagePlayerEvent>(_onLoadPagePlayer);
  }

  Future<void> _onLoadPagePlayer(
    LoadPagePlayerEvent event,
    Emitter<PagePlayerState> emit,
  ) async {
    emit(const PagePlayerLoading());
    try {
      final page = await pageRepository.getPage();
      emit(PagePlayerLoaded(page: page));
    } catch (e) {
      emit(PagePlayerError(message: e.toString()));
    }
  }
}