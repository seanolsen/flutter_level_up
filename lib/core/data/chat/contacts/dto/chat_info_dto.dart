
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../_converters/boollable_datetime2nullable_datetime_converter.dart';
import '../../../_converters/boollable_int2nullable_int_converter.dart';
import '../../../_converters/boollable_string2nullable_string_converter.dart';

part 'chat_info_dto.freezed.dart';
part 'chat_info_dto.g.dart';

@freezed
abstract class ChatInfoDto with _$ChatInfoDto {
  const ChatInfoDto._();

  factory ChatInfoDto({
    @BoolableInt2NullableIntConverter()
      required int? id,
    @BoolableDateTime2NullableDateTimeConverter()
      required DateTime? time,
    @BoollableString2NullableStringConverter()
      required String? status, // "status": "inited",
    @JsonKey(name: 'unread_cnt') required int unreadCount,
    // @JsonKey(name: 'is_free') required int isFree,
    // @JsonKey(name: 'time_last_active_man') required DateTime timeLastActiveMan,
    @JsonKey(name: 'last_message_time') required DateTime? lastMessageTime,
    @JsonKey(name: 'message') required String? lastMessageText,
  }) = _ChatInfoDto;

  factory ChatInfoDto.fromJson(Map<String, dynamic> json) => _$ChatInfoDtoFromJson(json);

  // ChatInfo toDomain() {
  //   return ChatInfo(
  //     id: id,
  //     time: time,
  //     status: status == null
  //       ? ChatStatus.closed
  //       : (
  //         status == 'started'
  //           ? ChatStatus.active
  //           : (
  //             status == 'initiated' || status == 'inited'
  //               ? ChatStatus.initiated
  //               : ChatStatus.invite
  //           )
  //       ),
  //     unreadCount: unreadCount,
  //     lastMessageTime: lastMessageTime,
  //     lastMessageText: lastMessageText,
  //   );
  // }

  // factory ChatInfoDto.fromDomain(ChatInfo chatInfo) {
  //   return ChatInfoDto(
  //     id: chatInfo.id,
  //     time: chatInfo.time,
  //     status: chatInfo.status == ChatStatus.closed
  //       ? 'false'
  //       : (
  //         chatInfo.status == ChatStatus.active
  //           ? 'started'
  //           : (
  //             chatInfo.status == ChatStatus.initiated
  //               ? 'inited'
  //               : 'request'
  //           )
  //       ),
  //     unreadCount: chatInfo.unreadCount,
  //     lastMessageTime: chatInfo.lastMessageTime,
  //     lastMessageText: chatInfo.lastMessageText,
  //   );
  // }
}
