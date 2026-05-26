import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_info_dto.dart';
import 'contact_update_dto.dart';
import 'profile_dto.dart';
import 'video_stream_info_dto.dart';

part 'contact_dto.freezed.dart';
part 'contact_dto.g.dart';

@freezed
abstract class ContactDto with _$ContactDto {
  const ContactDto._();

  const factory ContactDto({
    String? type,
    @JsonKey(name: 'user') required ProfileDto profile,
    @JsonKey(name: 'chat') required ChatInfoDto chatInfo,
    @JsonKey(name: 'videochat') required VideoStreamInfoDto videoStreamInfo,
    // String? note,
  }) = _ContactDto;

  factory ContactDto.fromJson(Map<String, dynamic> json) => _$ContactDtoFromJson(json);

  ContactDto applyUpdate(ContactUpdateDto contactUpdateDto) {
    return ContactDto(
      type: contactUpdateDto.type ?? type,
      profile: profile.applyUpdate(contactUpdateDto.profile),
      chatInfo: contactUpdateDto.chatInfo,
      videoStreamInfo: contactUpdateDto.videoStreamInfo ?? videoStreamInfo,
    );
  }
}
