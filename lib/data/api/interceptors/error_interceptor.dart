import 'package:dio/dio.dart';

import '../../../core/services/api_error_handler.dart';
import '../../../core/services/api_exception.dart';
import '../../../core/services/session_manager.dart';

/// Convierte errores Dio en [ApiException] y limpia sesión ante 401.
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor(this._sessionManager);

  final SessionManager _sessionManager;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final apiException = ApiErrorHandler.fromDioException(err);

    if (apiException.isUnauthorized) {
      await _sessionManager.clearSession();
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: apiException,
        message: apiException.message,
      ),
    );
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final statusCode = response.statusCode ?? 0;
    if (statusCode >= 400) {
      final apiException = ApiErrorHandler.fromResponse(response);
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: apiException,
          message: apiException.message,
        ),
      );
      return;
    }
    handler.next(response);
  }
}

/// Expone utilidad para extraer [ApiException] desde cualquier error.
ApiException? readApiException(Object? error) {
  if (error is ApiException) return error;
  if (error is DioException && error.error is ApiException) {
    return error.error as ApiException;
  }
  return null;
}
