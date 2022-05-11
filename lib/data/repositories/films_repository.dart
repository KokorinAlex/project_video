import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:project_video/app/constants.dart';
import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/app/models/home_model.dart';
import 'package:project_video/data/dtos/show_card_dto.dart';
import 'package:project_video/data/mappers/show_mapper.dart';
import 'package:project_video/data/repositories/interceptor/dio_error_interceptor.dart';

class FilmsRepository {
  final Function(String, String) onErrorHandler;

  late final Dio _dio;

  FilmsRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
        ErrorInterceptor(onErrorHandler),
      ]);
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
}
