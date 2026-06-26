import 'package:dio/dio.dart';

import 'api_exception.dart';

/// Mapea errores de [Dio] y respuestas HTTP a [ApiException].
class ApiErrorHandler {
  ApiErrorHandler._();

  static ApiException fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'La solicitud tardó demasiado. Intenta de nuevo.',
          statusCode: error.response?.statusCode,
          code: 'timeout',
          originalError: error,
        );
      case DioExceptionType.connectionError:
        return ApiException(
          message: 'Sin conexión con el servidor.',
          code: 'connection_error',
          originalError: error,
        );
      case DioExceptionType.cancel:
        return ApiException(
          message: 'Solicitud cancelada.',
          code: 'cancelled',
          originalError: error,
        );
      case DioExceptionType.badResponse:
        return _fromResponse(error.response, error);
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return ApiException(
          message: 'Ocurrió un error inesperado.',
          statusCode: error.response?.statusCode,
          code: 'unknown',
          originalError: error,
        );
    }
  }

  static ApiException fromResponse(Response<dynamic>? response) {
    return _fromResponse(response, null);
  }

  static ApiException _fromResponse(
    Response<dynamic>? response,
    DioException? error,
  ) {
    final statusCode = response?.statusCode;
    final data = response?.data;
    String message = 'Error en la solicitud.';
    String? code;

    if (data is Map<String, dynamic>) {
      final detail = data['detail'];
      if (detail is Map<String, dynamic>) {
        message = detail['message']?.toString() ?? message;
        code = detail['code']?.toString();
      } else if (detail is String) {
        message = detail;
      }
    }

    if (statusCode == 401) {
      message = 'Sesión expirada o no autorizada.';
      code ??= 'not_authenticated';
    }

    return ApiException(
      message: message,
      statusCode: statusCode,
      code: code,
      originalError: error ?? response,
    );
  }
}
