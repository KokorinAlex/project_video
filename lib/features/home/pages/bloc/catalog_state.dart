import 'package:equatable/equatable.dart';
import 'package:project_video/app/models/home_model.dart';

class CatalogState extends Equatable {
  final String? search;
  final Future<HomeModel?>? data;

  const CatalogState({this.search, this.data});

  CatalogState copyWith({String? search, Future<HomeModel?>? data}) =>
      CatalogState(
        search: search ?? this.search,
        data: data ?? this.data,
      );

  @override
  List<Object?> get props => [search ?? 0, data ?? 0];
}
