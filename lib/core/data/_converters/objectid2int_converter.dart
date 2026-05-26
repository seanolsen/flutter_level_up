import 'package:freezed_annotation/freezed_annotation.dart';

class ObjectIdToIntConverter implements JsonConverter<int, Map<String, dynamic>> {
  const ObjectIdToIntConverter();
  
  @override
  int fromJson(Map<String, dynamic> json) {
    return int.parse(json['id'].toString());
  }

  @override
  Map<String, dynamic> toJson(int fieldValue) => {'id': fieldValue};
}
