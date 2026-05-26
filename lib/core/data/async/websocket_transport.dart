import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../app/constants.dart';
import 'command_container.dart';
import 'dtos.dart';
import 'i_transport.dart';

@LazySingleton(as: IAsyncCommandsTransport)
class WebsocketTransport implements IAsyncCommandsTransport {
  WebSocketChannel? _websocket;

  final Map<CommandName, List<Function(Map<String, dynamic> command)>> _callbacks = {};
  
  @override
  void connect({
    required String privateChannelId,
    required String publicChannelId,
  }) {
    if (_websocket == null) {
      final uri = Uri.parse('${Constants.textChatMessagingWebsocketHostUrl}/ws/$privateChannelId/$publicChannelId');
      _websocket = WebSocketChannel.connect(uri);

      _websocket!.stream.listen(_websocketStreamListener);
    }
  }

  @override
  void disconnect() {
    _websocket?.sink.close();
    _websocket?.stream.drain();
    _websocket = null;
  }

  void _websocketStreamListener(dynamic data) {
    try {
      final rawData = data.toString().trim();
      if (rawData.isEmpty) {
        return;
      }

      // remove trailing comma from batched payload
      final preparedData =rawData.endsWith(',') ? rawData.substring(0, rawData.length - 1) : rawData;
      final jsonList = jsonDecode('[$preparedData]') as List<dynamic>;
      _processMessage(jsonList);
    } catch (_) {
      // Ignore malformed websocket chunks and continue processing next events.
    }
  }

  void _processMessage(List<dynamic> jsonList) {
    for (final json in jsonList) {
      try {
        // Expect each entry to be a JSON object matching CommandsWrapperDto.
        final processedCommands = CommandsWrapperDto.fromJson(json as Map<String, dynamic>);

        for (final commandContainer in processedCommands.commandsListWithMetadata.commands) {
          try {
            // if ((commandContainer.name == CommandName.userUpdate && commandContainer.data['user']['id'] == 84468) ||
            // (commandContainer.name == CommandName.contactUpdate && commandContainer.data['user']['id'] == 84468)) {
            //   print('commandContainer: $commandContainer');
            // }
            if (_callbacks.containsKey(commandContainer.name)) {
              for (final callback in _callbacks[commandContainer.name]!) {
                callback.call(commandContainer.data);
              }
            }
          } on StateError catch(_) {
            // Unrecognized command name – skip silently.
          }
        }
      } catch (e) {
        // Malformed or unexpected payload – ignore this message instead of
        // crashing the app.
        // print('Malformed or unexpected payload: $json');
        continue;
      }
    }
  }

  @override
  void subscribeTo(CommandName commandType, Function(Map<String, dynamic> command) callback) {
    if (!_callbacks.containsKey(commandType)) {

      _callbacks[commandType] = <Function(Map<String, dynamic> command)>[];
    }

    _callbacks[commandType]!.add(callback);
  }
}
