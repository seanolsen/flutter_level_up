import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/websocket_info.dart';

part 'authenticated_customer_config.freezed.dart';

@freezed
abstract class AuthenticatedCustomerConfig with _$AuthenticatedCustomerConfig {
  const factory AuthenticatedCustomerConfig({
    required WebsocketInfo websocket,
  }) = _AuthenticatedCustomerConfig;
}
