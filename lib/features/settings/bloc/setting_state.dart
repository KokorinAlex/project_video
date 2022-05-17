import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  final String? name;

  const SettingState({
    this.name,
  });

  @override
  List<Object> get props => [name ?? ''];

  SettingState copyWith({
    String? name,
  }) {
    return SettingState(
      name: name ?? this.name,
    );
  }
}
