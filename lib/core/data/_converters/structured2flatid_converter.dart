
import 'package:json_annotation/json_annotation.dart';

class StructuredToFlatIdConverter implements JsonConverter<int, Object> {
  const StructuredToFlatIdConverter();

  @override
  int fromJson(Object json) {
    return (json as Map<String, dynamic>)['id'];
  }

  @override
  Object toJson(int fieldValue) => {'id': fieldValue};
}
