import '../../data/enums.dart';
import '../../data/models/answer_model.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/exam_model.dart';
import '../../data/models/question_model.dart';

/// Datos mock para desarrollo sin backend.
///
/// Activar con: `flutter run --dart-define=OFFLINE_MODE=true`
class OfflineData {
  OfflineData._();

  static const String accessToken = 'offline-demo-token';
  static const int studentId = 1;
  static const int studentExamId = 9001;
  static const int durationMinutes = 90;

  static DateTime? _examStartedAt;
  static int _answerIdCounter = 1;

  static AuthSession authSession({
    required String email,
    String? fullName,
  }) {
    return AuthSession(
      accessToken: accessToken,
      tokenType: 'bearer',
      expiresIn: 86400,
      user: AuthUser(
        id: 1,
        email: email,
        role: UserRole.student,
        studentId: studentId,
        fullName: fullName ?? email.split('@').first,
      ),
    );
  }

  static AuthUser authUserFromSession({
    required String email,
    String? fullName,
    int? studentId,
  }) {
    return AuthUser(
      id: 1,
      email: email,
      role: UserRole.student,
      studentId: studentId ?? OfflineData.studentId,
      fullName: fullName,
    );
  }

  static ExamTemplate examTemplate(int templateId) {
    final now = DateTime.now();
    return ExamTemplate(
      id: templateId,
      admissionProcessId: 1,
      name: 'Simulacro UNSA (demo offline)',
      durationMinutes: durationMinutes,
      questionCount: 5,
      isActive: true,
      createdAt: now,
      updatedAt: now,
      templateQuestions: List.generate(
        5,
        (i) => ExamTemplateQuestion(
          id: i + 1,
          questionId: i + 1,
          displayOrder: i + 1,
        ),
      ),
    );
  }

  static void resetExamClock() {
    _examStartedAt = DateTime.now();
    _answerIdCounter = 1;
  }

  static StudentExam studentExam({int? id}) {
    final now = DateTime.now();
    _examStartedAt ??= now;
    final examId = id ?? studentExamId;

    return StudentExam(
      id: examId,
      studentId: studentId,
      examTemplateId: 1,
      status: StudentExamStatus.inProgress,
      startedAt: _examStartedAt,
      finishedAt: null,
      createdAt: now,
      updatedAt: now,
      questions: _demoQuestions,
      answers: const [],
    );
  }

  static ExamTimeStatus examTimeStatus(int studentExamId) {
    final started = _examStartedAt ?? DateTime.now();
    _examStartedAt ??= started;
    final totalSeconds = durationMinutes * 60;
    final elapsed = DateTime.now().difference(started).inSeconds;
    final remaining = (totalSeconds - elapsed).clamp(0, totalSeconds);

    return ExamTimeStatus(
      studentExamId: studentExamId,
      status: remaining == 0
          ? StudentExamStatus.expired
          : StudentExamStatus.inProgress,
      startedAt: started,
      finishedAt: null,
      durationMinutes: durationMinutes,
      elapsedSeconds: elapsed,
      remainingSeconds: remaining,
      isExpired: remaining == 0,
    );
  }

  static StudentAnswer submitAnswer({
    required int studentExamId,
    required int questionId,
    required int selectedOptionId,
  }) {
    final now = DateTime.now();
    return StudentAnswer(
      id: _answerIdCounter++,
      studentExamId: studentExamId,
      questionId: questionId,
      selectedOptionId: selectedOptionId,
      isCorrect: null,
      timeSeconds: 30,
      answeredAt: now,
      createdAt: now,
    );
  }

  static final List<QuestionForExam> _demoQuestions = [
    _question(
      id: 1,
      order: 1,
      stem: 'Si x + 5 = 12, ¿cuál es el valor de x?',
      options: [
        ('A', '5'),
        ('B', '7'),
        ('C', '17'),
        ('D', '60'),
      ],
    ),
    _question(
      id: 2,
      order: 2,
      stem: '¿Cuál es el área de un triángulo con base 10 cm y altura 6 cm?',
      options: [
        ('A', '16 cm²'),
        ('B', '30 cm²'),
        ('C', '60 cm²'),
        ('D', '120 cm²'),
      ],
    ),
    _question(
      id: 3,
      order: 3,
      stem: 'Simplifica la expresión: 3(x + 2) - 2x',
      options: [
        ('A', 'x + 6'),
        ('B', 'x + 2'),
        ('C', '5x + 6'),
        ('D', '3x + 4'),
      ],
    ),
    _question(
      id: 4,
      order: 4,
      stem: '¿Cuál es el valor de 2³ × 2²?',
      options: [
        ('A', '2⁵'),
        ('B', '2⁶'),
        ('C', '4⁵'),
        ('D', '8²'),
      ],
    ),
    _question(
      id: 5,
      order: 5,
      stem: 'Un número es divisible entre 3 si la suma de sus dígitos es divisible entre 3. ¿Cuál cumple esa condición?',
      options: [
        ('A', '124'),
        ('B', '235'),
        ('C', '348'),
        ('D', '457'),
      ],
    ),
  ];

  static QuestionForExam _question({
    required int id,
    required int order,
    required String stem,
    required List<(String, String)> options,
  }) {
    return QuestionForExam(
      id: id,
      subtopicId: 1,
      stem: stem,
      difficulty: 2,
      displayOrder: order,
      options: List.generate(
        options.length,
        (i) {
          final (label, text) = options[i];
          return QuestionOptionForExam(
            id: id * 10 + i + 1,
            label: label,
            text: text,
            displayOrder: i + 1,
          );
        },
      ),
    );
  }
}
