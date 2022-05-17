import 'package:equatable/equatable.dart';

import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/app/models/home_model.dart';

class HomeState extends Equatable {
  final String? search;
  final Future<HomeModel?>? data;
  final List<FilmCardModel>? favouriteFilms;

  const HomeState({
    this.favouriteFilms,
    this.search,
    this.data,
  });

  HomeState copyWith({
    String? search,
    Future<HomeModel?>? data,
    List<FilmCardModel>? favouriteFilms,
  }) {
    return HomeState(
      search: search ?? this.search,
      data: data ?? this.data,
      favouriteFilms: favouriteFilms ?? this.favouriteFilms,
    );
  }

  @override
  List<Object?> get props => [search ?? 0, data ?? 0, favouriteFilms ?? []];
}
