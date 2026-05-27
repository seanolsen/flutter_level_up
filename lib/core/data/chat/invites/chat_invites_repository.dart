import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../async/command_container.dart';
import '../../async/i_transport.dart';
import 'dto/chat_invite_dto.dart';
import 'dto/chat_invite_remove_dto.dart';
import 'i_chat_invites_repository.dart';
import 'local/i_chat_invites_local_data_source.dart';
import 'remote/i_chat_invites_remote_data_source.dart';

@LazySingleton(as: IChatInvitesRepository)
class ChatInvitesRepository implements IChatInvitesRepository {
  final IChatInvitesLocalDataSource _local;
  final IChatInvitesRemoteDataSource _remote;
  final IAsyncCommandsTransport _asyncCommandsTransport;

  Timer? _countdownTimer;
  StreamSubscription? _pollingSubscription;

  ChatInvitesRepository( this._local, this._remote, this._asyncCommandsTransport) {
    _setupAsyncCommands();
  }

  void _setupAsyncCommands() {
    _asyncCommandsTransport.subscribeTo(
      CommandName.requestAdd,
      (command) {
        final chatInviteDto = ChatInviteDto.fromJson(command);
        _local.add(chatInviteDto);
      },
    );

    _asyncCommandsTransport.subscribeTo(
      CommandName.requestDelete,
      (command) {
        final chatInviteRemoveDto = ChatInviteRemoveDto.fromJson(command);
        _local.remove(chatInviteRemoveDto.id);
      },
    );
  }

  @override
  Stream<List<ChatInviteDto>> watchAll() {
    _startPolling();
    _runCountdownTimer();

    return _local.watchAll()
        .map((invites) => _filterExpired(invites))
        .doOnCancel(() {
          _stopPolling();
          _stopCountdownTimer();
        });
  }

  Future<void> _startPolling() async {
    _pollingSubscription = _remote.watchAll().listen((invites) {
      _local.saveAll(invites);
    });
  }

  void _stopPolling() {
    _pollingSubscription?.cancel();
    _pollingSubscription = null;
  }

  void _runCountdownTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _ignoreExpiredInvites();
    });
  }

  void _stopCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  @override
  Future<void> decline(int inviteId) async {
    await _remote.decline(inviteId);
    await _local.remove(inviteId);
  }

  @override
  Future<void> accept(int inviteId) async {
    final invite = await _local.getById(inviteId);
    if (invite == null) {
      return Future.value();
    }

    await _remote.accept(invite.profile.id);
    await _local.remove(inviteId);
  }

  @override
  Future<void> markAsViewed(int inviteId) async {
    await _remote.markAsViewed(inviteId);
  }

  void _ignoreExpiredInvites() {
    final now = DateTime.now();
    _local.watchAll()
      .map((invites) {
        final expired = invites.where((invite) => !invite.expiresAt.isAfter(now)).toList();

        for (final invite in expired) {
          Future.microtask(() async {
            await _remote.ignore(invite.id);
            await _local.remove(invite.id);
          });
        }
      });
  }

  List<ChatInviteDto> _filterExpired(List<ChatInviteDto> invites) {
    final now = DateTime.now();
    return invites.where((invite) => invite.expiresAt.isAfter(now)).toList();
  }
}
