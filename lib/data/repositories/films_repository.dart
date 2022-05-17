import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:project_video/app/constants.dart';
import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/app/models/home_model.dart';
import 'package:project_video/data/db/database.dart';
import 'package:project_video/data/dtos/show_card_dto.dart';
import 'package:project_video/data/mappers/show_mapper.dart';
import 'package:project_video/data/repositories/interceptor/dio_error_interceptor.dart';

class FilmsRepository {
  final Function(String, String) onErrorHandler;

  late final Dio _dio;

  late final Database _db;

  FilmsRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
        ErrorInterceptor(onErrorHandler),
      ]);

    _db = Database();
  }

  Future<HomeModel?> loadData({required String q}) async {
    const String url = MovieQuery.baseUrl;
    final Response<dynamic> response = await _dio.get<List<dynamic>>(
      url,
      queryParameters: <String, dynamic>{'q': q},
    );

    final dtos = <ShowCardDTO>[];
    final responseList = response.data as List<dynamic>;
    for (final data in responseList) {
      dtos.add(
        ShowCardDTO.fromJson(data as Map<String, dynamic>),
      );
    }

    final filmsModel = <FilmCardModel>[];
    for (final dto in dtos) {
      filmsModel.add(dto.toDomain());
    }

    final HomeModel model = HomeModel(results: filmsModel);
    return model;
  }

  Future<List<FilmCardModel>> getAllFilmsDB() async {
    List<FilmsTableData> filmsDB = await _db.select(_db.filmsTable).get();
    return filmsDB
        .map((FilmsTableData filmsTableData) => filmsTableData.toDomain())
        .toList();
  }

  Future<void> insertFilmDB(FilmCardModel filmCardModel) async {
    await _db.into(_db.filmsTable).insert(
          filmCardModel.toDatabase(),
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<void> deleteFilmDB(int id) async {
    await (_db.delete(_db.filmsTable)
          ..where((filmTable) => filmTable.id.equals(id)))
        .go();
  }

  Stream<List<FilmCardModel>> onChangeFilmsDB() {
    return (_db.select(_db.filmsTable))
        .map((FilmsTableData filmsTableData) => filmsTableData.toDomain())
        .watch();
  }
}
