import 'package:dartz/dartz.dart';

import '../../../../core/errors.dart';
import '../../../../core/value_failure.dart';
import '../../../../core/value_validators.dart';

class WebsocketInfo {
  final Either<ValueFailure<String>, DateTime> cursor;
  final Either<ValueFailure<String>, String> privateChannelId;
  final Either<ValueFailure<String>, String> publicChannelId;

  factory WebsocketInfo({
    required DateTime cursor,
    required String privateChannelId,
    required String publicChannelId,
  }) {
    return WebsocketInfo._(
      right(cursor),
      validateStringNotEmpty(privateChannelId),
      validateStringNotEmpty(publicChannelId),
    );
  }

  const WebsocketInfo._(this.cursor, this.privateChannelId, this.publicChannelId);

  bool isValid() =>
      cursor.isRight() &&
      privateChannelId.isRight() &&
      publicChannelId.isRight();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WebsocketInfo &&
        other.cursor == cursor &&
        other.privateChannelId == privateChannelId &&
        other.publicChannelId == publicChannelId;
  }

  @override
  int get hashCode =>
      cursor.hashCode + privateChannelId.hashCode + publicChannelId.hashCode;

  @override
  String toString() =>
      'Value(cursor: $cursor , privateChannelId: $privateChannelId , publicChannelId: $publicChannelId)';

  DateTime getCursorOrCrash() {
    return cursor.fold((f) => throw UnexpectedValueError(f), (value) => value);
  }

  String getPrivateChannelIdOrCrash() {
    return privateChannelId.fold(
      (f) => throw UnexpectedValueError(f),
      (value) => value,
    );
  }

  String getPublicChannelIdOrCrash() {
    return publicChannelId.fold(
      (f) => throw UnexpectedValueError(f),
      (value) => value,
    );
  }
}
