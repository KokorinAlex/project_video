import 'dart:async';

enum LanguageEnum {
  russian,
  english,
  deutsche,
  unknown,
}

abstract class Films {
  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;

  Films(
      {required this.id,
      required this.title,
      required this.picture,
      required this.voteAverage,
      required this.releaseDate,
      required this.description,
      required this.language});

  LanguageEnum changeLanguage(String language) {
    switch (language) {
      case 'russian':
        return LanguageEnum.russian;
      case 'english':
        return LanguageEnum.english;
      case 'deutsche':
        return LanguageEnum.deutsche;
      default:
        return LanguageEnum.unknown;
    }
  }
}

mixin Converting {
  LanguageEnum changeLanguage(String language) {
    switch (language) {
      case 'russian':
        return LanguageEnum.russian;
      case 'english':
        return LanguageEnum.english;
      case 'deutsche':
        return LanguageEnum.deutsche;
      default:
        return LanguageEnum.unknown;
    }
  }
}

class NewFilm extends Films with Converting {
  NewFilm(
      {required int id,
      required String title,
      required String picture,
      required double voteAverage,
      required String releaseDate,
      required String description,
      required String language})
      : super(
            id: id,
            title: title,
            picture: picture,
            voteAverage: voteAverage,
            releaseDate: releaseDate,
            description: description,
            language: language);

  LanguageEnum? runConvert() {
    return changeLanguage(language);
  }
}

Future<List<NewFilm>> returnList() async {
  await Future.delayed(const Duration(seconds: 1));
  return [
    NewFilm(
      language: 'russian',
      id: 0,
      title: 'Брат',
      voteAverage: 8.3,
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/e9008e2f-433f-43b0-b9b8-2ea8e3fb6c9b/600x900',
      releaseDate: '1997',
      description:
          'Дембель Данила Багров защищает слабых в Петербурге 1990-х. Фильм, сделавший Сергея Бодрова народным героем.',
    ),
    NewFilm(
      language: 'russian',
      id: 1,
      title: 'Служебный роман',
      voteAverage: 8.3,
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/fd4e75bb-a6fe-46ef-86cd-0f470334fcbd/600x900',
      releaseDate: '1977',
      description:
          'Робкий холостяк решает приударить за строгой начальницей. Комедия Эльдара Рязанова, классика советского кино.',
    ),
    NewFilm(
      language: 'english',
      id: 2,
      title: 'Волк с Уолл-стрит',
      voteAverage: 7.9,
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/c5876e81-9dec-43e2-923f-fee2fca85e21/576x',
      releaseDate: '2013',
      description:
          'Восхождение циника-гедониста на бизнес-олимп 1980-х. Блистательный тандем Леонардо ДиКаприо и Мартина Скорсезе',
    ),
    NewFilm(
      language: 'deutsche',
      id: 3,
      title: 'Бриллиантовая рука',
      voteAverage: 8.5,
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/a419d20d-4ae6-4c7c-91b3-c38ef9ca1ffe/600x900',
      releaseDate: '1968',
      description:
          'Контрабандисты гоняются за примерным семьянином. Народная комедия с элементами абсурда от Леонида Гайдая',
    ),
    NewFilm(
      language: 'english',
      id: 4,
      title: 'Интерстеллар',
      voteAverage: 8.6,
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/430042eb-ee69-4818-aed0-a312400a26bf/600x900',
      releaseDate: '2014',
      description:
          'Фантастический эпос про задыхающуюся Землю, космические полеты и парадоксы времени. «Оскар» за спецэффекты',
    ),
  ];
  // List ret = [];
  // ret.add(itemFilm);
  // return ret;
}

extension LanguageExtension on LanguageEnum {
  String toPrettyString() {
    switch (this) {
      case LanguageEnum.russian:
        return 'Русский';
      case LanguageEnum.english:
        return 'Английский';
      case LanguageEnum.deutsche:
        return 'Немецкий';
      case LanguageEnum.unknown:
        return 'Неизвестный язык';
    }
  }
}

void filtrationFromRating(List<NewFilm> films, double value) {
  List ratingFilms = [];
  for (var item in films) {
    if (item.voteAverage >= value) {
      ratingFilms.add(item.title);
    }
  }
}
