import 'base_dto.dart';

class UniversityResponseDto extends BaseDto {
  const UniversityResponseDto({
    required this.id,
    required this.code,
    required this.name,
    required this.country,
    required this.isActive,
  });

  final int id;
  final String code;
  final String name;
  final String country;
  final bool isActive;

  factory UniversityResponseDto.fromJson(Map<String, dynamic> json) {
    return UniversityResponseDto(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      country: json['country'] as String? ?? 'PE',
      isActive: json['is_active'] as bool? ?? true,
    );
  }
}

class CareerResponseDto extends BaseDto {
  const CareerResponseDto({
    required this.id,
    required this.universityId,
    required this.code,
    required this.name,
    required this.isActive,
  });

  final int id;
  final int universityId;
  final String code;
  final String name;
  final bool isActive;

  factory CareerResponseDto.fromJson(Map<String, dynamic> json) {
    return CareerResponseDto(
      id: json['id'] as int,
      universityId: json['university_id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );
  }
}
