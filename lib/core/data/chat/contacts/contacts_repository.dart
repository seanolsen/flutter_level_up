import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/transformers.dart';

import '../../async/command_container.dart';
import '../../async/i_transport.dart';
import 'i_contacts_repository.dart';
import 'local/i_contacts_local_data_source.dart';
import 'dto/contact_dto.dart';
import 'dto/contact_update_dto.dart';
import 'dto/contact_remove_dto.dart';
import 'dto/contacts_list_dto.dart';
import 'dto/profile_partial_dto.dart';
import 'remote/i_contacts_remote_data_source.dart';

@LazySingleton(as: IContactsRepository)
class ContactsRepository implements IContactsRepository {
  final IContactsRemoteDataSource _remote;
  final IContactsLocalDataSource _local;
  final IAsyncCommandsTransport _asyncCommands;
  StreamSubscription? _pollSubscription;

  ContactsRepository(
    this._remote,
    this._local,
    this._asyncCommands,
  ) {
    _subscribeToAsyncCommands();
  }
/*
  int _sortCallback(ContactDto a, ContactDto b) {
    int priority(ContactDto contact) {
      final hasChatTime = contact.chatInfo.lastMessageTime != null
          || contact.chatInfo.time != null;
      if (hasChatTime) return 0;

      final hasChatId = contact.chatInfo.id != null;
      if (hasChatId) return 1;

      final isOnline = contact.profile.isOnline;
      final hasCamera = contact.profile.camera.isOnline > 0;

      if (isOnline && hasCamera) return 2;
      if (isOnline) return 3;
      if (contact.profile.isFavorite) return 4;
      return 4;
    }

    final aPriority = priority(a);
    final bPriority = priority(b);

    if (aPriority != bPriority) {
      return aPriority.compareTo(bPriority);
    }

    if (aPriority == 0) {
      final aTime = a.chatInfo.time ?? a.chatInfo.lastMessageTime!;
      final bTime = b.chatInfo.time ?? b.chatInfo.lastMessageTime!;

      return bTime.compareTo(aTime);
    }
    if (aPriority == 1) {
      final aChatId = a.chatInfo.id!;
      final bChatId = b.chatInfo.id!;

      return bChatId.compareTo(aChatId);
    }

    return a.profile.id.compareTo(b.profile.id);
  }
*/
  void _subscribeToAsyncCommands() {
    _asyncCommands.subscribeTo(
      CommandName.userUpdate,
      (command) async {
        final profilePartialDto = ProfilePartialDto.fromJson(
          command['user'] as Map<String, dynamic>,
        );
        await _local.updateProfileByPartial(profilePartialDto);
      },
    );

    _asyncCommands.subscribeTo(
      CommandName.contactUpdate,
      (command) async {
        final contactPartialDto = ContactUpdateDto.fromJson(command);
        await _local.updateByPartial(contactPartialDto);
      },
    );

    _asyncCommands.subscribeTo(
      CommandName.conactAdd,
      (command) async {
        final contactDto = ContactDto.fromJson(command);
        await _local.add(contactDto);
      },
    );

    _asyncCommands.subscribeTo(
      CommandName.contactDelete,
      (command) async {
        final contactRemoveDto = ContactRemoveDto.fromJson(command);
        await _local.remove(contactRemoveDto.profileId);
      },
    );
  }

  @override
  Stream<List<ContactDto>?> watchAll() {
    _startPolling();

    return _local
        .watchAll()
        .doOnCancel(() {
          _pollSubscription?.cancel();
          _pollSubscription = null;
        });
  }

  void _startPolling() {
    if (_pollSubscription != null) {
      return;
    }

    _pollSubscription = _remote.watchAll().listen(
      (contacts) {
        _local.saveAll(contacts);
      },
      onError: (error, _) {
        // Sentry.captureException(error);
      },
    );
  }

  @override
  Future<List<ContactDto>?> getAll({
    bool forceRemote = false,
  }) async {
    if (!forceRemote) {
      final cachedContacts = await _local.getAll();
      if (cachedContacts != null) {
        return cachedContacts;
      }
    }

    return await _remote.getAll();
  }

  @override
  Future<ContactDto?> getByProfileId(
    int profileId, {
    bool forceRemote = false,
  }) async {
    final contacts = await getAll(forceRemote: forceRemote);
    try {
      return contacts?.firstWhere((contact) => contact.profile.id == profileId);
    } on StateError {
      return null;
    }
  }

  @override
  Future<void> clearUnreadCount(int profileId) async {
    await _local.clearUnreadCount(profileId);
  }

  @override
  Future<void> remove(int profileId) async {
    await _remote.remove(profileId);
    await _local.remove(profileId);
  }

  // Тестовый метод для заполнения внутреннего кэша (только для тестов)
  @visibleForTesting
  void setCacheForTesting(dynamic cache) {
    final List<ContactDto> contactsDto = cache is ContactsListDto ? cache.contacts : (cache as List<ContactDto>);
    unawaited(_local.saveAll(contactsDto));
  }

  // Future<void> _patchContactWithNewMessage(
  //   int profileId,
  //   Message message,
  // ) async {
  //   final cachedContacts = await _getCachedContacts();
  //   if (cachedContacts == null) {
  //     return;
  //   }

  //   final contactIndex = cachedContacts.indexWhere(
  //     (contact) => contact.profile.id == profileId,
  //   );
  //   if (contactIndex < 0) {
  //     return;
  //   }

  //   final updatedContact = mergeLastMessage(
  //     cachedContacts[contactIndex],
  //     message,
  //   );
  //   if (updatedContact == cachedContacts[contactIndex]) {
  //     return;
  //   }

  //   cachedContacts[contactIndex] = updatedContact;
  //   await _local.cacheContacts(cachedContacts);
  //   onUpdate?.call(updatedContact);
  // }
}
