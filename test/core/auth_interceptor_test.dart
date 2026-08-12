import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headroom/core/network/auth_event_bus.dart';
import 'package:headroom/core/network/auth_interceptor.dart';
import 'package:headroom/core/storage/token_storage.dart';
import 'package:mocktail/mocktail.dart';

class _MockTokenStorage extends Mock implements TokenStorage {}

class _FakeErrorInterceptorHandler extends ErrorInterceptorHandler {
  DioException? passedError;

  @override
  void next(DioException err) {
    passedError = err;
  }
}

class _FakeRequestInterceptorHandler extends RequestInterceptorHandler {
  RequestOptions? passedOptions;

  @override
  void next(RequestOptions requestOptions) {
    passedOptions = requestOptions;
  }
}

DioException _dioExceptionFor(
  String path, {
  required String method,
  int statusCode = 401,
}) {
  final RequestOptions requestOptions = RequestOptions(
    path: path,
    method: method,
  );
  return DioException(
    requestOptions: requestOptions,
    response: Response<dynamic>(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: <String, dynamic>{'error': 'Unauthorized'},
    ),
    type: DioExceptionType.badResponse,
  );
}

void main() {
  late _MockTokenStorage tokenStorage;
  late AuthEventBus authEventBus;
  late AuthInterceptor interceptor;

  setUp(() {
    tokenStorage = _MockTokenStorage();
    when(() => tokenStorage.deleteToken()).thenAnswer((_) async {});
    when(() => tokenStorage.readToken()).thenAnswer((_) async => 'a-token');
    authEventBus = AuthEventBus();
    interceptor = AuthInterceptor(
      tokenStorage: tokenStorage,
      authEventBus: authEventBus,
    );
  });

  tearDown(() {
    authEventBus.dispose();
  });

  group('onRequest', () {
    test('attaches X-Client: mobile and a bearer token when one is stored', () async {
      final RequestOptions options = RequestOptions(path: '/entries');
      final _FakeRequestInterceptorHandler handler =
          _FakeRequestInterceptorHandler();

      interceptor.onRequest(options, handler);
      await Future<void>.delayed(Duration.zero);

      expect(handler.passedOptions?.headers['X-Client'], 'mobile');
      expect(
        handler.passedOptions?.headers['Authorization'],
        'Bearer a-token',
      );
    });

    test('omits Authorization when no token is stored', () async {
      when(() => tokenStorage.readToken()).thenAnswer((_) async => null);
      final RequestOptions options = RequestOptions(path: '/onboarding/starters');
      final _FakeRequestInterceptorHandler handler =
          _FakeRequestInterceptorHandler();

      interceptor.onRequest(options, handler);
      await Future<void>.delayed(Duration.zero);

      expect(handler.passedOptions?.headers.containsKey('Authorization'), isFalse);
    });
  });

  group('onError - 401 handling', () {
    test('clears the token and notifies the auth bus for a 401 on a protected route', () async {
      final DioException error = _dioExceptionFor('/auth/me', method: 'GET');
      final _FakeErrorInterceptorHandler handler = _FakeErrorInterceptorHandler();

      final Future<void> unauthorizedFired = authEventBus.onUnauthorized.first;

      interceptor.onError(error, handler);
      await Future<void>.delayed(Duration.zero);

      verify(() => tokenStorage.deleteToken()).called(1);
      await expectLater(unauthorizedFired, completes);
      expect(handler.passedError, error);
    });

    test('does NOT clear the token for a 401 from POST /auth/login', () async {
      final DioException error = _dioExceptionFor('/auth/login', method: 'POST');
      final _FakeErrorInterceptorHandler handler = _FakeErrorInterceptorHandler();

      bool unauthorizedFired = false;
      final subscription = authEventBus.onUnauthorized.listen((_) {
        unauthorizedFired = true;
      });

      interceptor.onError(error, handler);
      await Future<void>.delayed(Duration.zero);

      verifyNever(() => tokenStorage.deleteToken());
      expect(unauthorizedFired, isFalse);
      expect(handler.passedError, error);
      await subscription.cancel();
    });

    test('does NOT clear the token for non-401 errors', () async {
      final DioException error = _dioExceptionFor(
        '/entries',
        method: 'GET',
        statusCode: 500,
      );
      final _FakeErrorInterceptorHandler handler = _FakeErrorInterceptorHandler();

      interceptor.onError(error, handler);
      await Future<void>.delayed(Duration.zero);

      verifyNever(() => tokenStorage.deleteToken());
      expect(handler.passedError, error);
    });

    test('still recognises a trailing-slash login path as login', () async {
      final DioException error = _dioExceptionFor(
        'https://headroom.me.uk/api/auth/login/',
        method: 'POST',
      );
      final _FakeErrorInterceptorHandler handler = _FakeErrorInterceptorHandler();

      interceptor.onError(error, handler);
      await Future<void>.delayed(Duration.zero);

      verifyNever(() => tokenStorage.deleteToken());
    });
  });
}
