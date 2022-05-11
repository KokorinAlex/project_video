import 'package:dio/dio.dart';
import 'package:project_video/app/constants.dart';

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor(this.onErrorHandler);

  final Function(String, String) onErrorHandler;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    onErrorHandler(
      err.response?.statusCode?.toString() ?? MovieLocal.unknown,
      err.message,
    );
    handler.next(err);
  }
}
