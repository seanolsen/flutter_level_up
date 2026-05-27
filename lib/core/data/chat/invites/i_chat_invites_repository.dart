import 'dto/chat_invite_dto.dart';

abstract class IChatInvitesRepository {
  Stream<List<ChatInviteDto>> watchAll();
  Future<void> decline(int inviteId);
  Future<void> accept(int inviteId);
  Future<void> markAsViewed(int inviteId);
}
