import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_video/error_bloc/error_event.dart';
import 'package:project_video/error_bloc/error_state.dart';
import 'package:project_video/features/dailogs/error_dialog.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(const ErrorState()) {
    on<ShowDialogEvent>(_onShowDialog);
  }

  void _onShowDialog(ShowDialogEvent event, Emitter<ErrorState> emit) {
    showErrorDialog(error: '${event.title} ${event.message}');
  }
}
