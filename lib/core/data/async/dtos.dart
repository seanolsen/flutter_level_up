import 'package:freezed_annotation/freezed_annotation.dart';

import 'command_container.dart';

part 'dtos.freezed.dart';
part 'dtos.g.dart';

@freezed
abstract class CommandsWrapperDto with _$CommandsWrapperDto {
  const CommandsWrapperDto._();

  const factory CommandsWrapperDto({
    @JsonKey(name: 'data') required CommandsListWithMetadataDto commandsListWithMetadata,
  }) = _CommandsWrapperDto;
  
  factory CommandsWrapperDto.fromJson(Map<String, dynamic> json) => _$CommandsWrapperDtoFromJson(json);
}

@freezed
abstract class CommandsListWithMetadataDto with _$CommandsListWithMetadataDto {
  const CommandsListWithMetadataDto._();

  const factory CommandsListWithMetadataDto({
    required String channel,
    required double cursor,
    required String hash,
    @JsonKey(name: 'data') @CommandDataConverter() required List<CommandContainer> commands,
  }) = _CommandsListWithMetadataDto;

  factory CommandsListWithMetadataDto.fromJson(Map<String, dynamic> json) => _$CommandsListWithMetadataDtoFromJson(json);
}

@freezed
abstract class CommandDto with _$CommandDto {
  const CommandDto._();

  const factory CommandDto({
    @JsonKey(name: 'a') required String action,
    @JsonKey(name: 'd') required Map<String, dynamic> data,
  }) = _CommandDto;
  
  factory CommandDto.fromJson(Map<String, dynamic> json) => _$CommandDtoFromJson(json);
}

class CommandDataConverter implements JsonConverter<List<CommandContainer>, Object> {
  const CommandDataConverter();

  @override
  List<CommandContainer> fromJson(Object json) {
    final List<CommandContainer> commands = [];
  
    for (var item in (json as List)) {
      final CommandDto commandDto = CommandDto.fromJson(item);

      try {
        final CommandName commandName = CommandName.values.firstWhere(
          (element) => element.name.toLowerCase() == commandDto.action.replaceAll(RegExp(r'_'), '').toLowerCase(),
        );

        commands.add(
          CommandContainer(
            name: commandName,
            data: commandDto.data,
          ),
        );
      } on StateError catch(_) {
        // skip unknown command
      }
    }

    return commands;
  }

  @override
  Object toJson(List<CommandContainer> fieldValue) => fieldValue;
}
