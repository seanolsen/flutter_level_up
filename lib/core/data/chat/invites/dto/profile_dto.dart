import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../_converters/string2int_converter.dart';
import 'profile_partial_dto.dart';

part 'profile_dto.freezed.dart';
part 'profile_dto.g.dart';

@freezed
abstract class ProfileDto with _$ProfileDto {
  const ProfileDto._();

  const factory ProfileDto({
    @String2IntConverter() @JsonKey(name: 'id') required int id,
    required String name,
    required String photoUrl,
    @String2IntConverter() required int age,
    // @Int2BoolConverter() @JsonKey(name: 'online') required bool isOnline,
    // @Int2BoolConverter() @JsonKey(name: 'favorite') required bool isFavorite,
    // @Int2BoolConverter() @JsonKey(name: 'blocked') bool? isBlocked,
    // @ObjectCameraAllowToBoolConverter() @JsonKey(name: 'camera') required bool isCameraAllowed,
  }) = _ProfileDto;

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);

  // factory ProfileDto.fromCrossContext(ct.ProfileDto profileDto) => ProfileDto(
  //   id: profileDto.id,
  //   name: profileDto.name,
  //   photo: ProfilePhotoDto.fromCrossContext(profileDto.photo),
  //   age: profileDto.age,
  //   isOnline: profileDto.isOnline,
  //   isFavorite: profileDto.isFavorite,
  //   isBlocked: profileDto.isBlocked,
  //   camera: ProfileCameraDto.fromCrossContext(profileDto.camera),
  // );

  ProfileDto applyUpdate(ProfilePartialDto profilePartialDto) {
    return ProfileDto(
      id: id,
      name: profilePartialDto.name ?? name,
      photoUrl: profilePartialDto.photoUrl ?? photoUrl,
      age: profilePartialDto.age ?? age,
      // photo: profilePartialDto.photo ?? photo,
      // age: profilePartialDto.age ?? age,
      // isOnline: profilePartialDto.isOnline ?? isOnline,
      // isFavorite: profilePartialDto.isFavorite ?? isFavorite,
      // isBlocked: profilePartialDto.isBlocked ?? isBlocked,
      // isCameraAllowed: profilePartialDto.isCameraAllowed  ?? isCameraAllowed,
    );
  }

  // ChatProfile toDomain() {
  //   return ChatProfile(
  //     id: id,
  //     name: name,
  //     photo: photo.toDomain(),
  //     age: age,
  //     isOnline: isOnline,
  //     isFavorite: isFavorite,
  //     isBlocked: isBlocked ?? false,
  //     camera: camera.toDomain(),
  //   );
  // }

  // factory ProfileDto.fromDomain(ChatProfile chatProfile) => ProfileDto(
  //   id: chatProfile.id,
  //   name: chatProfile.name,
  //   photo: ProfilePhotoDto.fromDomain(chatProfile.photo),
  //   age: chatProfile.age,
  //   isOnline: chatProfile.isOnline,
  //   isFavorite: chatProfile.isFavorite,
  //   isBlocked: chatProfile.isBlocked,
  //   camera: ProfileCameraDto.fromDomain(chatProfile.camera),
  // );
}
