import '../dto/catalog_dto.dart';
import 'api_client.dart';
import 'api_paths.dart';
import 'base_response.dart';

class CatalogApi {
  const CatalogApi(this._client);

  final ApiClient _client;

  Future<BaseResponse<List<UniversityResponseDto>>> listUniversities({
    bool activeOnly = true,
  }) {
    return _client.requestList(
      call: () => _client.get(
        ApiPaths.universities,
        queryParameters: {'active_only': activeOnly},
      ),
      itemParser: UniversityResponseDto.fromJson,
    );
  }

  Future<BaseResponse<List<CareerResponseDto>>> listCareers({
    required int universityId,
    bool activeOnly = true,
  }) {
    return _client.requestList(
      call: () => _client.get(
        ApiPaths.careers,
        queryParameters: {
          'university_id': universityId,
          'active_only': activeOnly,
        },
      ),
      itemParser: CareerResponseDto.fromJson,
    );
  }
}
