import 'package:flutter/material.dart';
import 'dart:async';

enum LanguageEnum {
  russian,
  english,
  deutsche,
}

abstract class Films {
  String id;
  String title;
  String picture;
  double voteAverage;
  String releaseDate;
  String description;
  String language;

  Films(
      {required this.id,
      required this.title,
      required this.picture,
      required this.voteAverage,
      required this.releaseDate,
      required this.description,
      required this.language});
}

mixin Converting {
  LanguageEnum? changeLanguage(String language) {
    switch (language) {
      case 'russian':
        return LanguageEnum.russian;
      case 'english':
        return LanguageEnum.english;
      case 'deutsche':
        return LanguageEnum.deutsche;
      default:
        return null;
    }
  }
}

class NewFilm extends Films with Converting {
  NewFilm(
      {required String id,
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

  bool filterOfVideo(NewFilm film) {
    if (film.voteAverage >= 9) {
      return true;
    } else {
      return false;
    }
  }

  LanguageEnum? runConvert() {
    return changeLanguage(language);
  }
}

Future<List> returnList() async {
  return [
    NewFilm(
        id: '',
        title: 'Harry Potter',
        picture: '',
        voteAverage: 10.0,
        releaseDate: '',
        description: '',
        language: 'english'),
    NewFilm(
        id: '',
        title: 'Silicon Valle',
        picture: '',
        voteAverage: 15,
        releaseDate: '',
        description: '',
        language: 'english'),
    NewFilm(
        id: '',
        title: 'Bad film',
        picture: '',
        voteAverage: 2.0,
        releaseDate: '',
        description: '',
        language: 'english'),
  ];
  // List ret = [];
  // ret.add(itemFilm);
  // return ret;
}

extension LanguageExtension on LanguageEnum {
  String get nameOfLanguage {
    switch (this) {
      case LanguageEnum.russian:
        return 'Русский';
      case LanguageEnum.english:
        return 'Английский';
      case LanguageEnum.deutsche:
        return 'Немецкий';
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
  print(ratingFilms);
  return;
}

void main() {
  var film = NewFilm(
      id: '',
      title: '',
      picture: '',
      voteAverage: 12,
      releaseDate: '',
      description: '',
      language: 'russian');
  var output = film.runConvert();
  final pro = output?.nameOfLanguage;
  debugPrint(pro);

  List<NewFilm> listOfFilms = [
    NewFilm(
        id: '',
        title: 'Harry Potter',
        picture: '',
        voteAverage: 10.0,
        releaseDate: '',
        description: '',
        language: 'english'),
    NewFilm(
        id: '',
        title: 'Silicon Valle',
        picture: '',
        voteAverage: 15,
        releaseDate: '',
        description: '',
        language: 'english'),
    NewFilm(
        id: '',
        title: 'Bad film',
        picture: '',
        voteAverage: 2.0,
        releaseDate: '',
        description: '',
        language: 'english'),
  ];

  filtrationFromRating(listOfFilms, 8);
}
