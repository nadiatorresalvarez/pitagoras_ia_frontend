import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../data/models/diagnostic_model.dart';
import '../../../data/repositories/results_repository.dart';

/// Coordina el diagnóstico académico post-examen.
class DiagnosticProvider {
  DiagnosticProvider({required ResultsRepository repository})
      : _repository = repository;

  final ResultsRepository _repository;

  Future<DiagnosticReport> getDiagnostic(int studentExamId) =>
      _repository.getDiagnostic(studentExamId);

  Future<List<DiagnosticItem>> getDiagnosticAreas(int studentExamId) =>
      _repository.getDiagnosticAreas(studentExamId);

  Future<List<DiagnosticItem>> getDiagnosticComponents(int studentExamId) =>
      _repository.getDiagnosticComponents(studentExamId);

  Future<List<DiagnosticItem>> getDiagnosticTopics(int studentExamId) =>
      _repository.getDiagnosticTopics(studentExamId);

  Future<List<DiagnosticItem>> getDiagnosticSubtopics(int studentExamId) =>
      _repository.getDiagnosticSubtopics(studentExamId);
}

final diagnosticProvider = Provider<DiagnosticProvider>((ref) {
  return DiagnosticProvider(repository: ref.watch(resultsRepositoryProvider));
});
