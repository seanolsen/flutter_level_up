
import 'package:json_annotation/json_annotation.dart';

class VideoStreamStatusToBoolConverter implements JsonConverter<bool, Map<String, dynamic>> {
  const VideoStreamStatusToBoolConverter();
  
  @override
  bool fromJson(Map<String, dynamic> json) {
    return json['status'] == 'on';
  }

  @override
  Map<String, dynamic> toJson(bool fieldValue) => { 'status': fieldValue ? 'on' : 'off' };
}
