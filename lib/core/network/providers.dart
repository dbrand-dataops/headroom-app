import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/token_storage.dart';
import 'auth_event_bus.dart';
import 'dio_client.dart';

final Provider<TokenStorage> tokenStorageProvider = Provider<TokenStorage>((
  ref,
) {
  return SecureTokenStorage();
});

final Provider<AuthEventBus> authEventBusProvider = Provider<AuthEventBus>((
  ref,
) {
  final AuthEventBus bus = AuthEventBus();
  ref.onDispose(bus.dispose);
  return bus;
});

final Provider<Dio> dioProvider = Provider<Dio>((ref) {
  return buildDioClient(
    tokenStorage: ref.watch(tokenStorageProvider),
    authEventBus: ref.watch(authEventBusProvider),
  );
});
