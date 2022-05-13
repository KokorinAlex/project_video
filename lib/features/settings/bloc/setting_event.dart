import 'package:equatable/equatable.dart';
import 'package:project_video/features/settings/pages/setting_page.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

class LoadNameEvent extends SettingEvent {
  const LoadNameEvent(SettingsArguments arguments);
}

class SaveNameEvent extends SettingEvent {
  final String name;

  const SaveNameEvent({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}

class ClearNameEvent extends SettingEvent {}
