import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LocaleState extends Equatable {
  const LocaleState(this.locale);

  final Locale locale;

  LocaleState copyWith({Locale? locale}) => LocaleState(locale ?? this.locale);

  @override
  List<Object> get props => [locale];
}
