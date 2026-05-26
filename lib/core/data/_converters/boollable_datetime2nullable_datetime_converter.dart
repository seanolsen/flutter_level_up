import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

class BoolableDateTime2NullableDateTimeConverter implements JsonConverter<DateTime?, Object> {
  const BoolableDateTime2NullableDateTimeConverter();
  static final DateFormat _formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  
  @override
  DateTime? fromJson(Object json) {
    try {
      final time = _formatter.parseUTC(json.toString());
      return time.add(Duration(hours: 5));
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  Object toJson(DateTime? fieldValue) {
    if (fieldValue == null) {
      return false;
    }

    // Keep cache serialization compatible with fromJson parser.
    return _formatter.format(fieldValue.toUtc());
  }
}
