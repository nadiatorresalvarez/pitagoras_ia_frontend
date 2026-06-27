/// Rutas nominales de la aplicación.
abstract final class RoutePaths {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const simulacro = '/simulacro';
  static const exam = '/examen';
  static const results = '/resultados';

  static const onboardingUniversity = '/onboarding/universidad';
  static const onboardingArea = '/onboarding/area';
  static const onboardingCareer = '/onboarding/carrera';

  static const diagnostic = '/diagnostico';
  static const diagnosticExam = '/diagnostico/examen';
  static const diagnosticProcessing = '/diagnostico/procesando';
  static const diagnosticResult = '/diagnostico/resultado';
  static const diagnosticRecommendations = '/diagnostico/recomendaciones';

  static String examSession(int studentExamId) => '$exam/$studentExamId';

  static String onboardingAreaPath({
    required String universityId,
    required String universityName,
  }) =>
      '$onboardingArea?universityId=$universityId&universityName=$universityName';

  static String onboardingCareerPath({
    required String universityId,
    required String universityName,
    required String areaId,
    required String areaName,
  }) =>
      '$onboardingCareer?universityId=$universityId&universityName=$universityName&areaId=$areaId&areaName=$areaName';

  static String diagnosticPath({
    required String careerName,
    required String universityName,
  }) =>
      '$diagnostic?careerName=${Uri.encodeComponent(careerName)}&universityName=${Uri.encodeComponent(universityName)}';

  static String diagnosticExamPath({
    required String careerName,
    required String universityName,
  }) =>
      '$diagnosticExam?careerName=${Uri.encodeComponent(careerName)}&universityName=${Uri.encodeComponent(universityName)}';

  static String diagnosticProcessingPath({
    required String careerName,
    required String universityName,
  }) =>
      '$diagnosticProcessing?careerName=${Uri.encodeComponent(careerName)}&universityName=${Uri.encodeComponent(universityName)}';

  static String diagnosticResultPath({
    required String careerName,
    required String universityName,
  }) =>
      '$diagnosticResult?careerName=${Uri.encodeComponent(careerName)}&universityName=${Uri.encodeComponent(universityName)}';

  static String diagnosticRecommendationsPath({
    required String careerName,
    required String universityName,
  }) =>
      '$diagnosticRecommendations?careerName=${Uri.encodeComponent(careerName)}&universityName=${Uri.encodeComponent(universityName)}';
}
