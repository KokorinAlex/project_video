import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_video/locale_bloc/locale_event.dart';
import 'package:project_video/locale_bloc/locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(Locale('ru', 'RU'))) {
    on<ChangeLocaleEvent>(_onLocaleChanged);
  }

  void _onLocaleChanged(ChangeLocaleEvent event, Emitter<LocaleState> emit) {
    emit(state.copyWith(locale: event.locale));
  }
}
