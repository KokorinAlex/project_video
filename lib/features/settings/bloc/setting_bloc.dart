import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_video/features/settings/bloc/setting_event.dart';
import 'package:project_video/features/settings/bloc/setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  static const String keyName = 'name';

  SettingBloc() : super(const SettingState()) {
    on<LoadNameEvent>(_onLoadName);
    on<SaveNameEvent>(_onSaveName);
    on<ClearNameEvent>(_onClearName);
  }

  void _onLoadName(LoadNameEvent event, Emitter<SettingState> emit) async {
    final pref = await SharedPreferences.getInstance();
    final String? name = pref.getString(keyName);
    emit(state.copyWith(name: name));
  }

  void _onSaveName(SaveNameEvent event, Emitter<SettingState> emit) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(keyName, event.name);
    emit(state.copyWith(name: event.name));
  }

  void _onClearName(ClearNameEvent event, Emitter<SettingState> emit) async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(keyName);
    emit(state.copyWith(name: ''));
  }
}
