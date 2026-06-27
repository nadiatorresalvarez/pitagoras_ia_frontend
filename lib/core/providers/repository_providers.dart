import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/api/auth_api.dart';
import '../../data/api/catalog_api.dart';
import '../../data/api/exam_api.dart';
import '../../data/api/results_api.dart';
import '../../data/api/tutor_api.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/catalog_repository.dart';
import '../../data/repositories/exam_repository.dart';
import '../../data/repositories/results_repository.dart';
import '../../data/repositories/tutor_repository.dart';
import 'api_client_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(AuthApi(ref.watch(apiClientProvider)));
});

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepository(CatalogApi(ref.watch(apiClientProvider)));
});

final examRepositoryProvider = Provider<ExamRepository>((ref) {
  return ExamRepository(ExamApi(ref.watch(apiClientProvider)));
});

final tutorRepositoryProvider = Provider<TutorRepository>((ref) {
  return TutorRepository(TutorApi(ref.watch(apiClientProvider)));
});

final resultsRepositoryProvider = Provider<ResultsRepository>((ref) {
  return ResultsRepository(ResultsApi(ref.watch(apiClientProvider)));
});
