import 'dto/contact_dto.dart';

abstract class IContactsRepository {
  Stream<List<ContactDto>?> watchAll();
  Future<List<ContactDto>?> getAll({bool forceRemote = false});
  Future<ContactDto?> getByProfileId(
    int profileId, {
    bool forceRemote = false,
  });
  Future<void> remove(int profileId);
  Future<void> clearUnreadCount(int profileId);
}
