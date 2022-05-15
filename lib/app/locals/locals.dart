import 'dart:async' show Future;

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart'
    show BuildContext, Locale, Localizations, LocalizationsDelegate;
import 'package:project_video/app/locals/locale_base.dart';
import 'package:project_video/app/locals/ru.dart';
import 'package:project_video/app/locals/en.dart';

const String ruLocale = 'ru_RU';
const String enLocale = 'en_US';

Map<String, LocaleBase> get initialLocals => <String, LocaleBase>{
      ruLocale: LocaleRu(),
      enLocale: LocaleEn(),
    };

Map<String, Locale> get availableLocales => <String, Locale>{
      ruLocale: const Locale('ru', 'RU'),
      enLocale: const Locale('en', 'US'),
    };

extension LocalContextExtension on BuildContext {
  LocaleBase get locale => Localizations.of<Locals>(this, Locals)!.current;
}

class Locals {
  Locals(this.locale, this.localizedValues) {
    current = localizedValues[locale.toString()] ?? initialLocals[ruLocale]!;
  }

  final Locale locale;

  final Map<String, LocaleBase> localizedValues;

  late LocaleBase current;
}

class MyLocalizationsDelegate extends LocalizationsDelegate<Locals> {
  Map<String, LocaleBase> localizedValues;

  MyLocalizationsDelegate(this.localizedValues);

  @override
  bool isSupported(Locale locale) =>
      localizedValues.keys.toList().contains(locale.toString());

  @override
  Future<Locals> load(Locale locale) => SynchronousFuture<Locals>(
        Locals(
          isSupported(locale) ? locale : availableLocales[ruLocale]!,
          localizedValues,
        ),
      );

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
