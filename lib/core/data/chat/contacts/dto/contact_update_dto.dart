import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_info_dto.dart';
import 'profile_partial_dto.dart';
import 'video_stream_info_dto.dart';

part 'contact_update_dto.freezed.dart';
part 'contact_update_dto.g.dart';

@freezed
abstract class ContactUpdateDto with _$ContactUpdateDto {
  const ContactUpdateDto._();

  const factory ContactUpdateDto({
    String? type,
    @JsonKey(name: 'user') required ProfilePartialDto profile,
    @JsonKey(name: 'chat') required ChatInfoDto chatInfo,
    @JsonKey(name: 'videochat') VideoStreamInfoDto? videoStreamInfo,
    // String? note,
  }) = _ContactUpdateDto;

  factory ContactUpdateDto.fromJson(Map<String, dynamic> json) => _$ContactUpdateDtoFromJson(json);
}
