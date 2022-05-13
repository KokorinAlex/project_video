import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class SearchChangedEvent extends HomeEvent {
  final String search;

  const SearchChangedEvent({required this.search});

  @override
  List<Object> get props => [search];
}

class LoadDataEvent extends HomeEvent {}
