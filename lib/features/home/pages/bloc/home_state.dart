import 'package:equatable/equatable.dart';
import 'package:project_video/app/models/home_model.dart';

class HomeState extends Equatable {
  final String? search;
  final Future<HomeModel?>? data;

  const HomeState({this.search, this.data});

  HomeState copyWith({String? search, Future<HomeModel?>? data}) => HomeState(
        search: search ?? this.search,
        data: data ?? this.data,
      );

  @override
  List<Object?> get props => [search ?? 0, data ?? 0];
}
