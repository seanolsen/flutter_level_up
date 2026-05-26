import 'package:freezed_annotation/freezed_annotation.dart';

class ObjectCameraAllowToBoolConverter implements JsonConverter<bool, Map<String, dynamic>> {
  const ObjectCameraAllowToBoolConverter();
  
  @override
  bool fromJson(Map<String, dynamic> json) {
    return json['allow'] == 1;
  }

  @override
  Map<String, dynamic> toJson(bool fieldValue) => {'allow': fieldValue ? 1 : 0};
}
