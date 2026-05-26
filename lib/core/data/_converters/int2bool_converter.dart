import 'package:freezed_annotation/freezed_annotation.dart';

class Int2BoolConverter implements JsonConverter<bool, Object> {
  const Int2BoolConverter();
  
  @override
  bool fromJson(Object json) {
    try {
      return int.parse(json.toString())>0;
    } on FormatException {
      return false;
    }
  }

  @override
  Object toJson(bool fieldValue) => fieldValue ? 1 : 0;
}
