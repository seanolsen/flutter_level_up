import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../exceptions.dart';
import '../dto/contacts_list_dto.dart';
import '../dto/contact_dto.dart';
import 'i_contacts_remote_data_source.dart';

@LazySingleton(as: IContactsRemoteDataSource)
class ContactsRemoteDataSource implements IContactsRemoteDataSource {
  final Dio _httpClient;

  ContactsRemoteDataSource(this._httpClient);

  @override
  Stream<List<ContactDto>> watchAll() {
    return Stream.periodic(const Duration(seconds: 30))
      .asyncMap((_) => _fetchAll());
  }

  @override
  Future<List<ContactDto>> getAll() async {
    return _fetchAll();
  }

  Future<List<ContactDto>> _fetchAll() async {
    try {
      final response = await _httpClient.get(
        '/api/v4/chat/contact/list/',
      );

      if (response.data['data'] == null) {
        throw EmptyResponseException();
      }

      final contactsList = ContactsListDto.fromJson(response.data);

      return contactsList.contacts;
    } on DioException catch (_) {
      throw ServerErrorException();
    } on Error catch (_) {
      throw UnexpectedErrorException();
    }
  }

  @override
  Future<void> remove(int profileId) async {
    try {
      await _httpClient.delete(
        '/api/v4/chat/contact/$profileId/',
      );
    } on DioException catch(e) {
      if (e.response != null) {
        if (e.response?.statusCode == HttpStatus.badRequest) {
          throw BadRequestException();
        }
      }
      
      throw ServerErrorException();
    } on Error catch (_) {
      throw UnexpectedErrorException();
    }
  }
}
