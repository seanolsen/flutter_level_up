import 'command_container.dart';

abstract class IAsyncCommandsTransport {
  void subscribeTo(CommandName commandName, Function(Map<String, dynamic> command) callback);
  void connect({
    required String privateChannelId,
    required String publicChannelId,
  });
  void disconnect();
}
