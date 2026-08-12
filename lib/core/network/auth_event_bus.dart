import 'dart:async';

/// A small broadcast bus that lets the network layer signal "the current
/// session is no longer valid" without depending on Riverpod or any
/// particular state-management shape. [AuthController] subscribes to
/// [onUnauthorized] and transitions to the unauthenticated state.
class AuthEventBus {
  final StreamController<void> _controller = StreamController<void>.broadcast();

  Stream<void> get onUnauthorized => _controller.stream;

  void notifyUnauthorized() {
    if (!_controller.isClosed) {
      _controller.add(null);
    }
  }

  void dispose() {
    unawaited(_controller.close());
  }
}
