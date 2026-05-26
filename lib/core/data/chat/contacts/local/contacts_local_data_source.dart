import 'package:injectable/injectable.dart';

import '../../../../../objectbox.g.dart';
import '../dto/contact_dto.dart';
import '../dto/contact_update_dto.dart';
import '../dto/profile_partial_dto.dart';
import 'entities/contact_cache_entity.dart';
import 'mappers/contact_cache_entity.dart';
import 'i_contacts_local_data_source.dart';

@LazySingleton(as: IContactsLocalDataSource)
class ContactsLocalDataSource implements IContactsLocalDataSource {
  final Box<ContactCacheEntity> _box;

  ContactsLocalDataSource(Store store)
      : _box = store.box<ContactCacheEntity>();
  
  @override
  Stream<List<ContactDto>> watchAll() {
    return _box
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find().map((e) => e.fromCacheEntity()).toList());
  }

  @override
  Future<List<ContactDto>?> getAll() async {
    return _box
        .query()
        .build()
        .find()
        .map((e) => e.fromCacheEntity())
        .toList();
  }

  @override
  Future<void> saveAll(List<ContactDto> contacts) async {
    try {
      _box.removeAll();
      _box.putMany(contacts.map((e) => e.toCacheEntity()).toList());
    } catch (e) {
      throw Exception('Failed to save contacts: $e');
    }
  }

  @override
  Future<void> updateByPartial(
    ContactUpdateDto contactUpdateDto,
  ) async {
    final cachedContact = _box
        .query(ContactCacheEntity_.profileId.equals(contactUpdateDto.profile.id))
        .build()
        .findFirst();
    if (cachedContact == null) {
      return;
    }

    final updatedContact = cachedContact.fromCacheEntity().applyUpdate(contactUpdateDto);
    _box.put(updatedContact.toCacheEntity(), mode: PutMode.update);
  }

  @override
  Future<void> updateProfileByPartial(
    ProfilePartialDto profilePartialDto,
  ) async {
    final cachedContact = _box
        .query(ContactCacheEntity_.profileId.equals(profilePartialDto.id))
        .build()
        .findFirst();
    if (cachedContact == null) {
      return;
    }

    final updatedProfile = cachedContact.fromCacheEntity().profile.applyUpdate(profilePartialDto);
    final updatedContact = cachedContact.fromCacheEntity().copyWith(profile: updatedProfile);
    _box.put(updatedContact.toCacheEntity(), mode: PutMode.update);
  }

  @override
  Future<void> clearUnreadCount(int profileId) async {
    final cachedContact = _box
        .query(ContactCacheEntity_.profileId.equals(profileId))
        .build()
        .findFirst();
    if (cachedContact == null) {
      return;
    }
    final updatedContact = cachedContact.fromCacheEntity().copyWith(chatInfo: cachedContact.fromCacheEntity().chatInfo.copyWith(unreadCount: 0));
    _box.put(updatedContact.toCacheEntity(), mode: PutMode.update);
  }

  @override
  Future<void> add(ContactDto contact) async {
    _box.put(contact.toCacheEntity());
  }

  @override
  Future<bool> remove(int profileId) async {
    return _box.remove(profileId);
  }

  @override
  Future<void> clear() async {
    _box.removeAll();
  }
}
