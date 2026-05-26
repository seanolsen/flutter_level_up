import 'package:freezed_annotation/freezed_annotation.dart';

part 'command_container.freezed.dart';

enum CommandName {
  userUpdate,
  messageSend,
  conactAdd,
  contactDelete,
  contactUpdate,
  requestAdd,
  requestDelete,
}

@freezed
abstract class CommandContainer with _$CommandContainer {
  const CommandContainer._();

  const factory CommandContainer({
    required CommandName name,
    required Map<String, dynamic> data,
  }) = _CommandContainer;
}