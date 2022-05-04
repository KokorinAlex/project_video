import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:project_video/app/constants.dart';
import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/app/models/home_model.dart';
import 'package:project_video/data/dtos/show_card_dto.dart';
import 'package:project_video/data/mappers/show_mapper.dart';
import 'package:project_video/features/dailogs/error_dialog.dart';

class FilmsRepository {
  static final Dio _dio = Dio()
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );

  static Future<HomeModel?> loadData(BuildContext context,
      {required String q}) async {
    try {
      const String url = MovieQuery.baseUrl;
      final Response<dynamic> response = await _dio.get<List<dynamic>>(
        url,
        queryParameters: <String, dynamic>{'q': q},
      );

      final dtos = <ShowCardDTO>[];
      final responceList = response.data as List<dynamic>;
      for (final data in responceList) {
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
    } on DioError catch (error) {
      final statusCode = error.response?.statusCode;
      showErrorDialog(context, error: statusCode?.toString() ?? '');
      return null;
    }
  }
}
