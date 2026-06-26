import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../data/dto/agents_dto.dart';
import '../../../data/models/agents_model.dart';
import '../../../data/repositories/results_repository.dart';

/// Coordina los agentes IA post-examen (diagnóstico, motivador, padres).
class AgentsProvider {
  AgentsProvider({required ResultsRepository repository}) : _repository = repository;

  final ResultsRepository _repository;

  Future<AgentInsight> analyzeDiagnostic(AgentRunRequestDto request) =>
      _repository.analyzeDiagnostic(request);

  Future<AgentInsight> encourageStudent(AgentRunRequestDto request) =>
      _repository.encourageStudent(request);

  Future<AgentInsight> parentReport(AgentRunRequestDto request) =>
      _repository.parentReport(request);
}

final agentsProvider = Provider<AgentsProvider>((ref) {
  return AgentsProvider(repository: ref.watch(resultsRepositoryProvider));
});
