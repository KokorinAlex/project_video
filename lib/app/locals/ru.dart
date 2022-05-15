import 'package:project_video/app/locals/locale_base.dart';

class LocaleRu implements LocaleBase {
  @override
  String get catalog => 'Каталог';

  @override
  String get details => 'Подробнее';

  @override
  String get error => 'Ошибка';

  @override
  String get favourites => 'Избранное';

  @override
  String get ratingPrefix => 'Рэйтинг: ';

  @override
  String get releaseDate => 'Дата выхода: ';

  @override
  String get search => 'Поиск';

  @override
  String get switchLanguage => 'Сменить язык';

  @override
  String get unknown => 'Неизвестно';
}
