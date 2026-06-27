/// Rutas relativas a [AppConfig.apiRoot] (`/api/v1`).
abstract final class ApiPaths {
  // Auth
  static const authRegister = '/auth/register';
  static const authLogin = '/auth/login';
  static const authMe = '/auth/me';

  // Exam engine
  static String examTemplate(int templateId) => '/exam-templates/$templateId';
  static const studentExams = '/student-exams';
  static String studentExam(int studentExamId) => '/student-exams/$studentExamId';
  static String studentExamTime(int studentExamId) =>
      '/student-exams/$studentExamId/time';
  static String studentExamAnswers(int studentExamId) =>
      '/student-exams/$studentExamId/answers';
  static String studentExamFinish(int studentExamId) =>
      '/student-exams/$studentExamId/finish';
  static String studentExamResults(int studentExamId) =>
      '/student-exams/$studentExamId/results';

  // Tutor
  static const tutorExplain = '/tutor/explain';

  // Diagnostics
  static String diagnostic(int studentExamId) =>
      '/diagnostics/student-exams/$studentExamId';
  static String diagnosticAreas(int studentExamId) =>
      '/diagnostics/student-exams/$studentExamId/areas';
  static String diagnosticComponents(int studentExamId) =>
      '/diagnostics/student-exams/$studentExamId/components';
  static String diagnosticTopics(int studentExamId) =>
      '/diagnostics/student-exams/$studentExamId/topics';
  static String diagnosticSubtopics(int studentExamId) =>
      '/diagnostics/student-exams/$studentExamId/subtopics';

  // Recommendations
  static String studyPlan(int studentExamId) =>
      '/recommendations/student-exams/$studentExamId';

  // Agents
  static const agentDiagnosticAnalyze = '/agents/diagnostic/analyze';
  static const agentMotivatorEncourage = '/agents/motivator/encourage';
  static const agentParentsReport = '/agents/parents/report';

  // Catálogo académico
  static const universities = '/universities';
  static const careers = '/careers';
}
