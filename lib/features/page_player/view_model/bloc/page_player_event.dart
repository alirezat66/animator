import 'package:equatable/equatable.dart';

abstract class PagePlayerEvent extends Equatable {
  const PagePlayerEvent();

  @override
  List<Object> get props => [];
}

class LoadPagePlayerEvent extends PagePlayerEvent {
  const LoadPagePlayerEvent();

  @override
  List<Object> get props => [];
}
