import '../dto/contact_dto.dart';
import '../dto/contact_update_dto.dart';
import '../dto/profile_partial_dto.dart';

abstract class IContactsLocalDataSource {
  Stream<List<ContactDto>> watchAll();
  Future<List<ContactDto>?> getAll();
  Future<void> saveAll(List<ContactDto> contacts);
  Future<void> updateByPartial(ContactUpdateDto contactUpdateDto);
  Future<void> updateProfileByPartial(ProfilePartialDto profilePartialDto);
  Future<void> clearUnreadCount(int profileId);
  Future<void> add(ContactDto contact);
  Future<bool> remove(int profileId);
  Future<void> clear();
}
