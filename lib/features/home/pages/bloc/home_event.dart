import 'package:equatable/equatable.dart';
import 'package:project_video/app/models/film_card_model.dart';

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

class ChangedFavouritesEvent extends HomeEvent {
  final FilmCardModel? model;

  const ChangedFavouritesEvent({required this.model});
}

class ChangeFilmsDBEvent extends HomeEvent {
  final List<FilmCardModel> models;

  const ChangeFilmsDBEvent({required this.models});
}
