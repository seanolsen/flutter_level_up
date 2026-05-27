import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../_converters/int2bool_converter.dart';
import '../../../_converters/string2int_converter.dart';
import '../../contacts/dto/profile_dto.dart';

part 'chat_invite_dto.freezed.dart';
part 'chat_invite_dto.g.dart';

@freezed
abstract class ChatInviteDto with _$ChatInviteDto {
  const ChatInviteDto._();

  const factory ChatInviteDto({
    @String2IntConverter() required int id,
    // @String2DateTimeWithTimezoneUpdateConverter()
    @JsonKey(name: 'time') required DateTime createdAt,
    @JsonKey(name: 'expire') required DateTime expiresAt,
    @Int2BoolConverter() @JsonKey(name: 'viewed') required bool isViewed,
    required String? message,
    String? requestText,
    @JsonKey(name: 'user') required ProfileDto profile,
  }) = _ChatInviteDto;

  factory ChatInviteDto.fromJson(Map<String, dynamic> json) => _$ChatInviteDtoFromJson(json);

  // ChatInvite toDomain() {
  //   return ChatInvite(
  //     id: id,
  //     createdAt: createdAt,
  //     expiresAt: expiresAt,
  //     isViewed: isViewed,
  //     message: requestText ?? message,
  //     profile: profile.toDomain(),
  //   );
  // }

  // factory ChatInviteDto.fromDomain(ChatInvite chatInvite) => ChatInviteDto(
  //   id: chatInvite.id,
  //   createdAt: chatInvite.createdAt,
  //   expiresAt: chatInvite.expiresAt,
  //   isViewed: chatInvite.isViewed,
  //   message: chatInvite.message,
  //   profile: ProfileDto.fromDomain(chatInvite.profile),
  // );
}

class String2DateTimeWithTimezoneUpdateConverter implements JsonConverter<DateTime, String> {
  const String2DateTimeWithTimezoneUpdateConverter();
  
  @override
  DateTime fromJson(String json) {
    String preparedJson;
    if (!json.contains('T')) {
      preparedJson = '${json.replaceAll(' ', 'T')}-05:00';
    } else {
      preparedJson = json;
    }
    return DateTime.parse(preparedJson);
  }

  @override
  String toJson(DateTime fieldValue) => DateFormat('yyyy.MM.ddTHH:mm:ss Z').format(fieldValue);
}
