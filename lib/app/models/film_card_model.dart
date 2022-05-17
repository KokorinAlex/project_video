import 'package:project_video/data/db/database.dart';

class FilmCardModel {
  final int id;
  final String title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final String? description;

  const FilmCardModel({
    required this.id,
    required this.title,
    this.picture,
    this.voteAverage,
    this.releaseDate,
    this.description,
  });
}

extension FilmCardModelToDatabase on FilmCardModel {
  FilmsTableData toDatabase() {
    return FilmsTableData(
      id: id,
      title: title,
      picture: picture,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      description: description,
    );
  }
}

extension FilmTableDataToDomain on FilmsTableData {
  FilmCardModel toDomain() {
    return FilmCardModel(
      id: id,
      title: title,
      picture: picture,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      description: description,
    );
  }
}
