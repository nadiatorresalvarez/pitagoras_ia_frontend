import '../api/catalog_api.dart';
import '../mappers/catalog_mapper.dart';
import '../models/catalog_model.dart';
import 'base_repository.dart';

class CatalogRepository extends BaseRepository {
  const CatalogRepository(this._api);

  final CatalogApi _api;

  Future<List<University>> listUniversities({bool activeOnly = true}) async {
    final response = await _api.listUniversities(activeOnly: activeOnly);
    return response.data.map(CatalogMapper.toUniversity).toList();
  }

  Future<List<Career>> listCareers({
    required int universityId,
    bool activeOnly = true,
  }) async {
    final response = await _api.listCareers(
      universityId: universityId,
      activeOnly: activeOnly,
    );
    return response.data.map(CatalogMapper.toCareer).toList();
  }
}
