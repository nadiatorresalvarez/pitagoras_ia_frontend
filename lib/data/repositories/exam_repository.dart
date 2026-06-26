import '../api/exam_api.dart';
import '../dto/answer_dto.dart';
import '../dto/exam_dto.dart';
import '../mappers/answer_mapper.dart';
import '../mappers/exam_mapper.dart';
import '../mappers/results_mapper.dart';
import '../models/answer_model.dart';
import '../models/exam_model.dart';
import '../models/results_model.dart';
import 'base_repository.dart';

class ExamRepository extends BaseRepository {
  const ExamRepository(this._api);

  final ExamApi _api;

  Future<ExamTemplate> getExamTemplate(int templateId) async {
    final response = await _api.getExamTemplate(templateId);
    return ExamMapper.toTemplate(response.data);
  }

  Future<StudentExam> startStudentExam(StartStudentExamRequestDto request) async {
    final response = await _api.startStudentExam(request);
    return ExamMapper.toStudentExam(response.data);
  }

  Future<StudentExam> getStudentExam(int studentExamId) async {
    final response = await _api.getStudentExam(studentExamId);
    return ExamMapper.toStudentExam(response.data);
  }

  Future<ExamTimeStatus> getExamTimeStatus(int studentExamId) async {
    final response = await _api.getExamTimeStatus(studentExamId);
    return ExamMapper.toTimeStatus(response.data);
  }

  Future<StudentAnswer> submitAnswer(
    int studentExamId,
    SubmitAnswerRequestDto request,
  ) async {
    final response = await _api.submitAnswer(studentExamId, request);
    return AnswerMapper.toStudentAnswer(response.data);
  }

  Future<StudentExamResult> finishStudentExam(int studentExamId) async {
    final response = await _api.finishStudentExam(studentExamId);
    return ResultsMapper.toStudentExamResult(response.data);
  }
}
