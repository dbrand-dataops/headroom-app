/// Runtime configuration for the API base URL.
///
/// Defaults to the production Headroom API. Override for local development
/// with:
///   flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000/api
class Environment {
  const Environment._();

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://headroom.me.uk/api',
  );
}
