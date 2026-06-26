import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../data/dto/answer_dto.dart';
import '../../../data/dto/exam_dto.dart';
import '../../../data/models/answer_model.dart';
import '../../../data/models/exam_model.dart';
import '../../../data/models/results_model.dart';
import '../../../data/repositories/exam_repository.dart';

/// Coordina el flujo de examen (plantilla, sesión, respuestas, tiempo).
class ExamProvider {
  ExamProvider({required ExamRepository repository}) : _repository = repository;

  final ExamRepository _repository;

  Future<ExamTemplate> getExamTemplate(int templateId) =>
      _repository.getExamTemplate(templateId);

  Future<StudentExam> startStudentExam(StartStudentExamRequestDto request) =>
      _repository.startStudentExam(request);

  Future<StudentExam> getStudentExam(int studentExamId) =>
      _repository.getStudentExam(studentExamId);

  Future<ExamTimeStatus> getExamTimeStatus(int studentExamId) =>
      _repository.getExamTimeStatus(studentExamId);

  Future<StudentAnswer> submitAnswer(
    int studentExamId,
    SubmitAnswerRequestDto request,
  ) =>
      _repository.submitAnswer(studentExamId, request);

  Future<StudentExamResult> finishStudentExam(int studentExamId) =>
      _repository.finishStudentExam(studentExamId);
}

final examProvider = Provider<ExamProvider>((ref) {
  return ExamProvider(repository: ref.watch(examRepositoryProvider));
});
