import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_partial_dto.freezed.dart';
part 'profile_partial_dto.g.dart';

@freezed
abstract class ProfilePartialDto with _$ProfilePartialDto {
  const ProfilePartialDto._();

  const factory ProfilePartialDto({
    @JsonKey(name: 'id') required int id,
    String? name,
    String? photoUrl,
    int? age,
    // @Int2BoolConverter() @JsonKey(name: 'online') bool? isOnline,
    // @Int2BoolConverter() @JsonKey(name: 'favorite') bool? isFavorite,
    // @Int2BoolConverter() @JsonKey(name: 'blocked') bool? isBlocked,
    // @ObjectCameraAllowToBoolConverter() @JsonKey(name: 'camera') bool? isCameraAllowed,
  }) = _ProfilePartialDto;

  factory ProfilePartialDto.fromJson(Map<String, dynamic> json) => _$ProfilePartialDtoFromJson(json);
}
