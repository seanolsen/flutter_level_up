import 'package:injectable/injectable.dart';

import '../dto/chat_invite_dto.dart';
import 'i_chat_invites_local_data_source.dart';

@LazySingleton(as: IChatInvitesLocalDataSource)
class ChatInvitesLocalDataSource implements IChatInvitesLocalDataSource {
  List<ChatInviteDto>? _cachedData;

  @override
  Stream<List<ChatInviteDto>> watchAll() {
    return _cachedData != null ? Stream.value(_cachedData!) : Stream.empty();
  }

  @override
  Future<ChatInviteDto?> getById(int inviteId) {
    return Future.value(_cachedData?.firstWhere((e) => e.id == inviteId));
  }

  @override
  Future<void> saveAll(List<ChatInviteDto> chatInvites) {
    _cachedData = chatInvites;
    return Future.value();
  }

  @override
  Future<void> add(ChatInviteDto chatInvite) {
    _cachedData = [chatInvite, ..._cachedData ?? []];
    return Future.value();
  }

  @override
  Future<void> remove(int inviteId) {
    _cachedData = _cachedData?.where((e) => e.id != inviteId).toList();
    return Future.value();
  }

  @override
  Future<void> clear() {
    _cachedData = null;
    return Future.value();
  }
}