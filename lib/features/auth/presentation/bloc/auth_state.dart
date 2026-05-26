part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  factory AuthState({
    required AuthStatus authStatus,
    required Option<AuthenticatedCustomerConfig> authenticatedCustomerConfigOption,
  }) = _AuthState;

  factory AuthState.initial() => AuthState(
    authStatus: AuthStatus.uninitialized,
    authenticatedCustomerConfigOption: none(),
  );
}

enum AuthStatus {
  uninitialized,
  checkInProgress,
  authenticated,
  unauthenticated,
}
