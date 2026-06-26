import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../data/dto/tutor_dto.dart';
import '../../../data/models/tutor_model.dart';
import '../../../data/repositories/tutor_repository.dart';

/// Coordina las consultas al tutor IA.
class TutorProvider {
  TutorProvider({required TutorRepository repository}) : _repository = repository;

  final TutorRepository _repository;

  Future<TutorExplanation> explain(TutorExplainRequestDto request) =>
      _repository.explain(request);
}

final tutorProvider = Provider<TutorProvider>((ref) {
  return TutorProvider(repository: ref.watch(tutorRepositoryProvider));
});
