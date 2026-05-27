import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../_converters/string2int_converter.dart';

part 'chat_invite_remove_dto.freezed.dart';
part 'chat_invite_remove_dto.g.dart';

@freezed
abstract class ChatInviteRemoveDto with _$ChatInviteRemoveDto {
  const ChatInviteRemoveDto._();

  const factory ChatInviteRemoveDto({
    @String2IntConverter() required int id,
  }) = _ChatInviteRemoveDto;

  factory ChatInviteRemoveDto.fromJson(Map<String, dynamic> json) => _$ChatInviteRemoveDtoFromJson(json);
}
