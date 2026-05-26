import 'package:freezed_annotation/freezed_annotation.dart';

class String2IntConverter implements JsonConverter<int, Object> {
  const String2IntConverter();
  
  @override
  int fromJson(Object json) {
    return int.parse(json.toString());
  }

  @override
  Object toJson(int fieldValue) => fieldValue.toString();
}
