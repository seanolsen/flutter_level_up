part of 'auth_bloc.dart';

abstract class AuthEvent {}

@freezed
abstract class AuthInitRequestedEvent with _$AuthInitRequestedEvent implements AuthEvent {
  const factory AuthInitRequestedEvent() = _AuthInitRequestedEvent;
}
