import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MovieQuery {
  static const String baseUrl = 'https://api.tvmaze.com/search/shows';
  static const String pisecImageUrl =
      'http://risovach.ru/upload/2014/08/mem/sashko_57920362_orig_.jpg';
  static const String nothingImageUrl =
      'http://risovach.ru/upload/2016/03/mem/klichko_108546640_orig_.jpg';

  static const String initialQ = 'friends';
}

class MovieLocal {
//   static const String error = 'Ошибка';
  static const String unknown = 'Неизвестно';
//   static const String ratingPrefix = 'Оценка: ';
//   static const String ratingSuffix = '/ 10';
//   static const String search = 'Поиск';
}

/// Константы изображений
class MoviePictures {
  static CacheManager pictureCache =
      CacheManager(Config('movieImg', stalePeriod: const Duration(days: 7)));
}

/// Константы для цветов
class MovieColors {
  static const Color greenColor = Color.fromRGBO(54, 164, 94, 1);
  static const Color greyColor = Color.fromRGBO(84, 84, 84, 1);
  static const Color cardBlackColor = Color.fromRGBO(28, 28, 28, 1.0);
  static const Color backgroundBlackColor = Color.fromRGBO(16, 16, 16, 1.0);
}

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      MovieQuery.pisecImageUrl,
      fit: BoxFit.fitWidth,
    );
  }
}
