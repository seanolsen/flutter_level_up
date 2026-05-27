import '../dto/chat_invite_dto.dart';

abstract class IChatInvitesRemoteDataSource {
  Stream<List<ChatInviteDto>> watchAll();
  Future<void> decline(int inviteId);
  Future<void> ignore(int inviteId);
  Future<void> accept(int profileId);
  Future<void> markAsViewed(int inviteId);
}
