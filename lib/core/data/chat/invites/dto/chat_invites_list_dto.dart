import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_invite_dto.dart';

part 'chat_invites_list_dto.freezed.dart';
part 'chat_invites_list_dto.g.dart';

@freezed
abstract class ChatInvitesListDto with _$ChatInvitesListDto {
  const ChatInvitesListDto._();

  factory ChatInvitesListDto({
    @JsonKey(name: 'data') required List<ChatInviteDto> invites,
  }) = _ChatInvitesListDto;

  factory ChatInvitesListDto.fromJson(Map<String, dynamic> json) => _$ChatInvitesListDtoFromJson(json);

  // factory ChatInvitesListDto.fromList(List<ChatInviteDto> invites) {
  //   return ChatInvitesListDto(
  //     invites: invites,
  //   );
  // }

  // List<ChatInvite> toDomain() {
  //   return invites.map((invite) => invite.toDomain()).toList();
  // }
}
