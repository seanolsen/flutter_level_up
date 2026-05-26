import 'package:freezed_annotation/freezed_annotation.dart';

class BoolableInt2NullableIntConverter implements JsonConverter<int?, Object> {
  const BoolableInt2NullableIntConverter();
  
  @override
  int? fromJson(Object json) {
    try {
      return int.parse(json.toString());
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  Object toJson(int? fieldValue) => fieldValue ?? false;
}
