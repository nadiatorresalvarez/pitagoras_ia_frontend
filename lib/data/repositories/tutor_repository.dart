import '../api/tutor_api.dart';
import '../dto/tutor_dto.dart';
import '../mappers/tutor_mapper.dart';
import '../models/tutor_model.dart';
import 'base_repository.dart';

class TutorRepository extends BaseRepository {
  const TutorRepository(this._api);

  final TutorApi _api;

  Future<TutorExplanation> explain(TutorExplainRequestDto request) async {
    final response = await _api.explain(request);
    return TutorMapper.toExplanation(response.data);
  }
}
