import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../exceptions.dart';
import '../dto/chat_invite_dto.dart';
import '../dto/chat_invites_list_dto.dart';
import 'i_chat_invites_remote_data_source.dart';

@LazySingleton(as: IChatInvitesRemoteDataSource)
class ChatInvitesRemoteDataSource implements IChatInvitesRemoteDataSource {
  final Dio _httpClient;

  ChatInvitesRemoteDataSource(this._httpClient);

  @override
  Stream<List<ChatInviteDto>> watchAll() {
    return Stream.periodic(const Duration(seconds: 30))
      .asyncMap((_) => _fetchAll());
  }

  Future<List<ChatInviteDto>> _fetchAll() async {
    try {
      final response = await _httpClient.get(
        '/api/v4/chat/request/list/',
      );

      if (response.data['data'] == null) {
        throw EmptyResponseException();
      }

      final chatInvitesList = ChatInvitesListDto.fromJson(response.data);

      return chatInvitesList.invites;
    } on DioException {
      // log error
      throw ServerErrorException();
    } on Error catch (_) {
      // print(e);
      throw UnexpectedErrorException();
    }
  }

  @override
  Future<void> decline(int inviteId) async {
    try {
      await _httpClient.post(
        '/api/v4/chat/request/$inviteId/decline/',
      );
    } on DioException {
      throw ServerErrorException();
    }
  }

  @override
  Future<void> ignore(int inviteId) async {
    try {
      await _httpClient.post(
        '/api/v4/chat/request/$inviteId/ignore/',
      );
    } on DioException {
      throw ServerErrorException();
    }
  }

  @override
  Future<void> markAsViewed(int inviteId) async {
    try {
      await _httpClient.post(
        '/api/v4/chat/request/$inviteId/set-read/',
      );
    } on DioException {
      throw ServerErrorException();
    }
  }

  @override
  Future<void> accept(int profileId) async {
    try {
      await _httpClient.post(
        '/api/v4/chat/$profileId/message/send/',
        data: {
          'text': 'CHAT_SESSION_STARTED',
        },
      );
    } on DioException {
      throw ServerErrorException();
    }
  }
} 