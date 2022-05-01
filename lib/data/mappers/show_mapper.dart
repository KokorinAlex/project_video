import 'package:project_video/app/models/film_card_model.dart';
import 'package:project_video/data/dtos/show_card_dto.dart';

extension ShowCardDtoToDomain on ShowCardDTO {
  FilmCardModel toDomain() {
    return FilmCardModel(
      id: show?.id ?? 0,
      title: show?.title ?? '',
      picture: show?.picture?.original ?? '',
      releaseDate: show?.releaseDate,
      voteAverage: show?.voteAverage?.average,
      description: show?.description,
    );
  }
}
