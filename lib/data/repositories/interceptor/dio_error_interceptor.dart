import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
    _sendToCrashlytics(err);
    handler.next(err);
  }

  void _sendToCrashlytics(DioError err) {
    final customKeys = <String, String>{
      'path': err.requestOptions.uri.path,
      'url': err.requestOptions.uri.host,
      'response_type': err.requestOptions.responseType.toString(),
      'query_params': err.requestOptions.queryParameters.toString(),
    };
    for (final k in customKeys.keys) {
      FirebaseCrashlytics.instance.setCustomKey(k, customKeys[k] ?? '-');
    }
    FirebaseCrashlytics.instance.recordError(
      err.message,
      err.stackTrace,
      printDetails: true,
    );
  }
}
