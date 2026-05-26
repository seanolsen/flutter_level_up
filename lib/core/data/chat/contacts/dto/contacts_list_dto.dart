import 'package:freezed_annotation/freezed_annotation.dart';

import 'contact_dto.dart';

part 'contacts_list_dto.freezed.dart';
part 'contacts_list_dto.g.dart';

@freezed
abstract class ContactsListDto with _$ContactsListDto {
  const ContactsListDto._();

  factory ContactsListDto({
    @JsonKey(name: 'data') required List<ContactDto> contacts,
  }) = _ContactsListDto;

  factory ContactsListDto.fromJson(Map<String, dynamic> json) => _$ContactsListDtoFromJson(json);
}
