import 'package:equatable/equatable.dart';

abstract class ErrorEvent extends Equatable {
  const ErrorEvent();

  @override
  List<Object> get props => [];
}

class ShowDialogEvent extends ErrorEvent {
  final String? title;
  final String? message;

  const ShowDialogEvent({this.title, this.message});

  @override
  List<Object> get props => [title ?? 0, message ?? 0];
}
