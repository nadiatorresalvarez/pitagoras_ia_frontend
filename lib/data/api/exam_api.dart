import '../dto/answer_dto.dart';
import '../dto/exam_dto.dart';
import '../dto/results_dto.dart';
import 'api_client.dart';
import 'api_paths.dart';
import 'base_response.dart';

/// Llamadas HTTP del motor de exámenes (CU-04 a CU-06).
class ExamApi {
  const ExamApi(this._client);

  final ApiClient _client;

  Future<BaseResponse<ExamTemplateResponseDto>> getExamTemplate(int templateId) {
    return _client.request(
      call: () => _client.get(ApiPaths.examTemplate(templateId)),
      parser: (json) =>
          ExamTemplateResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<StudentExamResponseDto>> startStudentExam(
    StartStudentExamRequestDto request,
  ) {
    return _client.request(
      call: () => _client.post(ApiPaths.studentExams, data: request.toJson()),
      parser: (json) =>
          StudentExamResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<StudentExamResponseDto>> getStudentExam(int studentExamId) {
    return _client.request(
      call: () => _client.get(ApiPaths.studentExam(studentExamId)),
      parser: (json) =>
          StudentExamResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<ExamTimeStatusResponseDto>> getExamTimeStatus(
    int studentExamId,
  ) {
    return _client.request(
      call: () => _client.get(ApiPaths.studentExamTime(studentExamId)),
      parser: (json) =>
          ExamTimeStatusResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<StudentAnswerResponseDto>> submitAnswer(
    int studentExamId,
    SubmitAnswerRequestDto request,
  ) {
    return _client.request(
      call: () => _client.post(
        ApiPaths.studentExamAnswers(studentExamId),
        data: request.toJson(),
      ),
      parser: (json) =>
          StudentAnswerResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<BaseResponse<StudentExamResultResponseDto>> finishStudentExam(
    int studentExamId,
  ) {
    return _client.request(
      call: () => _client.post(ApiPaths.studentExamFinish(studentExamId)),
      parser: (json) =>
          StudentExamResultResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }
}
