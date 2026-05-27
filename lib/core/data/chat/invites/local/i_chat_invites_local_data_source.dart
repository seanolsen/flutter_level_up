import '../dto/chat_invite_dto.dart';

abstract class IChatInvitesLocalDataSource {
  Stream<List<ChatInviteDto>> watchAll();
  Future<ChatInviteDto?> getById(int inviteId);
  Future<void> saveAll(List<ChatInviteDto> chatInvites);
  Future<void> add(ChatInviteDto chatInvite);
  Future<void> remove(int inviteId);
  Future<void> clear();
}
