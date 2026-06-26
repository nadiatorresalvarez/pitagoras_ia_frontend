/// Rutas nominales de la aplicación.
abstract final class RoutePaths {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const simulacro = '/simulacro';
  static const exam = '/examen';
  static const results = '/resultados';

  static String examSession(int studentExamId) => '$exam/$studentExamId';
}
