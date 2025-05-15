import 'package:equatable/equatable.dart';
import '../../model/data/page_model.dart';

abstract class PagePlayerState extends Equatable {
  const PagePlayerState();

  @override
  List<Object> get props => [];
}

class PagePlayerInitial extends PagePlayerState {
  const PagePlayerInitial();
}

class PagePlayerLoading extends PagePlayerState {
  const PagePlayerLoading();
}

class PagePlayerLoaded extends PagePlayerState {
  final PageModel page;

  const PagePlayerLoaded({required this.page});

  @override
  List<Object> get props => [page];
}

class PagePlayerError extends PagePlayerState {
  final String message;

  const PagePlayerError({required this.message});

  @override
  List<Object> get props => [message];
}
