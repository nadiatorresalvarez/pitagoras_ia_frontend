import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../data/models/results_model.dart';
import '../../../data/repositories/results_repository.dart';

/// Coordina resultados de examen y plan de estudio.
class ResultsProvider {
  ResultsProvider({required ResultsRepository repository}) : _repository = repository;

  final ResultsRepository _repository;

  Future<StudentExamResult> getStudentExamResults(int studentExamId) =>
      _repository.getStudentExamResults(studentExamId);

  Future<StudyPlan> getStudyPlan(int studentExamId) =>
      _repository.getStudyPlan(studentExamId);
}

final resultsProvider = Provider<ResultsProvider>((ref) {
  return ResultsProvider(repository: ref.watch(resultsRepositoryProvider));
});
