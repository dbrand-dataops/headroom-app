# Headroom (Flutter client)

A stress-tracking mobile client for [Headroom](https://headroom.me.uk), built on
the stress-bucket model documented in `HEADROOM-DOCUMENTATION.md`. This is the
**Phase 1 foundation**: project setup, the API layer, authentication,
onboarding, and navigation. The bucket UI, entries, patterns and share
features are Phase 2.

## Requirements

- Flutter 3.35+ / Dart 3.13+ (stable channel)
- An Android emulator/device or iOS simulator/device to run on

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generate freezed/json_serializable code
flutter run
```

By default the app talks to the production API at
`https://headroom.me.uk/api`.

### Pointing at a local backend

The base URL is overridable at build/run time via `--dart-define`, without
touching any code:

```bash
# Android emulator (10.0.2.2 maps to the host machine's localhost)
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000/api

# iOS simulator (shares the host's localhost)
flutter run --dart-define=API_BASE_URL=http://localhost:3000/api

# A physical device on the same network as your dev machine
flutter run --dart-define=API_BASE_URL=http://192.168.1.23:3000/api
```

This also works for `flutter build` and `flutter test`.

## Project structure

```
lib/
  core/                  # Cross-feature building blocks
    config/              # Environment (base URL, --dart-define)
    error/                ApiException (typed { error, statusCode })
    models/               User, AuthResponse, Item, StarterItems (freezed)
    network/              Dio client, auth interceptor, auth event bus
    storage/               Secure token storage (flutter_secure_storage only)
    theme/                 App-wide Material 3 theme
    widgets/               Small shared widgets (e.g. ErrorBanner)
  features/
    auth/
      data/                AuthRepository (register/login/logout/me/forgotPassword)
      domain/              Client-side form validators
      state/               AuthController (unknown/unauthenticated/authenticated)
      screens/             Login, Register, Forgot Password
    onboarding/
      data/                OnboardingRepository (starters, complete)
      domain/              SelectableItem
      state/               OnboardingController
      screens/             OnboardingScreen, add-custom-item dialog
    home/                  Placeholder Home screen (Phase 2 replaces this)
  routing/                 go_router config, auth-state redirect, splash
  app.dart                 MaterialApp.router + theming
  main.dart                ProviderScope entry point
```

## Authentication and session handling

- The app always sends `X-Client: mobile`, so `/auth/register` and
  `/auth/login` return the session token in the response body. It's stored in
  `flutter_secure_storage` (Keychain on iOS, EncryptedSharedPreferences-backed
  Keystore on Android) — never in `SharedPreferences`, and never logged.
- Every request gets `Authorization: Bearer <token>` attached automatically
  when a token is stored.
- A `401` response clears the stored token and flips the app to the
  unauthenticated state, which the router picks up and redirects to `/login`.
  The one exception is `POST /auth/login` itself: a `401` there means "wrong
  credentials", not "your session expired", so it's shown inline on the login
  form instead.
- On app start, if a token is already stored it's validated against
  `GET /auth/me`; an invalid/expired token falls back to unauthenticated
  rather than crashing.

## Running tests

```bash
flutter test
```

This runs:

- `test/core/auth_interceptor_test.dart` — unit tests for the auth
  interceptor's header attachment and 401 handling (including the
  `/auth/login` exception).
- `test/routing/app_router_redirect_test.dart` — tests for the router's
  auth-state redirect logic across all four states.
- `test/features/auth/login_screen_test.dart` — widget tests for the login
  form's client-side validation and for surfacing a server error (with the
  `AuthRepository` mocked via `mocktail`).

To run a single file: `flutter test test/core/auth_interceptor_test.dart`.

## Static analysis

```bash
flutter analyze
```

`analysis_options.yaml` builds on `flutter_lints` with `strict-casts`,
`strict-inference` and `strict-raw-types` enabled, plus a handful of extra
rules (`unawaited_futures`, `require_trailing_commas`,
`prefer_final_locals`, etc.).

## Regenerating code

Any change to a `@freezed`/`@JsonSerializable` model requires regenerating
code:

```bash
dart run build_runner build --delete-conflicting-outputs
# or, while iterating:
dart run build_runner watch --delete-conflicting-outputs
```

## Notes on API integration

The API layer follows `HEADROOM-DOCUMENTATION.md` sections 8 (API reference)
and 9 (mobile integration guide) exactly:

- Base URL: `https://headroom.me.uk/api`, all JSON.
- Field names in models match the API's camelCase JSON verbatim.
- `ApiException` carries the server's `{ "error": "..." }` message and status
  code, plus the `upgrade` flag on tier-gated `403`s (surfaced in Phase 2).
- Onboarding's `POST /onboarding/complete` returns `400` both for validation
  failures and for "already onboarded", with no separate status code. Since
  the UI already enforces the validation rules client-side, a `400` whose
  message mentions "onboard" is treated as "already onboarded" and the flow
  continues to Home instead of showing a confusing error.
