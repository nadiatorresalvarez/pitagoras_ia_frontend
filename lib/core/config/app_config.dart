/// Configuración global de la aplicación.
///
/// Base URL: `flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000`
class AppConfig {
  AppConfig._();

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );

  static const String apiPrefix = '/api/v1';

  static String get apiRoot => '$apiBaseUrl$apiPrefix';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration sendTimeout = Duration(seconds: 30);

  /// Plantilla de examen UNSA (seed). Se usará en Fase 2.
  static const int examTemplateId = int.fromEnvironment(
    'EXAM_TEMPLATE_ID',
    defaultValue: 1,
  );
}
