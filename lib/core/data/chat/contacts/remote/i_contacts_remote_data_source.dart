import '../dto/contact_dto.dart';

abstract class IContactsRemoteDataSource {
  Stream<List<ContactDto>> watchAll();
  Future<List<ContactDto>> getAll();
  Future<void> remove(int profileId);
}
