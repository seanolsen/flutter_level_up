import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../_converters/objectid2int_converter.dart';

part 'contact_remove_dto.freezed.dart';
part 'contact_remove_dto.g.dart';

@freezed
abstract class ContactRemoveDto with _$ContactRemoveDto {
  const ContactRemoveDto._();

  const factory ContactRemoveDto({
    @ObjectIdToIntConverter() @JsonKey(name: 'user') required int profileId,
  }) = _ContactRemoveDto;

  factory ContactRemoveDto.fromJson(Map<String, dynamic> json) => _$ContactRemoveDtoFromJson(json);
}
