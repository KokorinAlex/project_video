import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_video/app/constants.dart';
import 'package:project_video/data/repositories/films_repository.dart';
import 'package:project_video/features/home/pages/bloc/home_event.dart';
import 'package:project_video/features/home/pages/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FilmsRepository repository;

  HomeBloc(this.repository) : super(const HomeState()) {
    on<LoadDataEvent>(_onLoadData);
    on<SearchChangedEvent>(_onSearchChanged);
  }

  String get search {
    final stateSearch = state.search;
    return (stateSearch != null && stateSearch.isNotEmpty)
        ? stateSearch
        : MovieQuery.initialQ;
  }

  void _onSearchChanged(SearchChangedEvent event, Emitter<HomeState> emit) {
    // search must be emitted before loading data
    emit(state.copyWith(search: event.search));
    emit(state.copyWith(data: repository.loadData(q: search)));
  }

  void _onLoadData(LoadDataEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(data: repository.loadData(q: search)));
  }
}
