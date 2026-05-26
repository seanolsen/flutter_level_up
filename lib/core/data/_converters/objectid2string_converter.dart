import 'package:freezed_annotation/freezed_annotation.dart';

class ObjectIdToStringConverter implements JsonConverter<String, Map<String, dynamic>> {
  const ObjectIdToStringConverter();
  
  @override
  String fromJson(Map<String, dynamic> json) {
    return json['id'].toString();
  }

  @override
  Map<String, dynamic> toJson(String fieldValue) => {'id': fieldValue};
}
