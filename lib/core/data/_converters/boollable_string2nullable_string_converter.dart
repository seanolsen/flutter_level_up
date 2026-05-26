import 'package:freezed_annotation/freezed_annotation.dart';

class BoollableString2NullableStringConverter implements JsonConverter<String?, Object> {
  const BoollableString2NullableStringConverter();

  @override
  String? fromJson(Object json) {
    return json.toString() == 'false' ? null : json.toString();
  }

  @override
  Object toJson(String? fieldValue) => fieldValue ?? false;
}
