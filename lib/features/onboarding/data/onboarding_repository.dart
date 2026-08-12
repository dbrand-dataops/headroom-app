import 'package:dio/dio.dart';

import '../../../core/models/item.dart';
import '../../../core/models/starter_items.dart';
import '../../../core/network/api_call.dart';

/// Talks to the `/api/onboarding` endpoints (section 8.2).
class OnboardingRepository {
  OnboardingRepository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  /// No auth required; the web UI prefetches this too.
  Future<StarterItems> getStarters() async {
    final Response<dynamic> response = await guardApiCall(
      () => _dio.get<dynamic>('/onboarding/starters'),
    );
    return StarterItems.fromJson(response.data as Map<String, dynamic>);
  }

  /// Returns the created item count. Throws [ApiException] with
  /// `statusCode == 400` both for validation failures and for the
  /// one-time-only "already onboarded" case - the server does not
  /// distinguish them with different status codes.
  Future<int> complete(List<Item> items) async {
    final Response<dynamic> response = await guardApiCall(
      () => _dio.post<dynamic>(
        '/onboarding/complete',
        data: <String, dynamic>{
          'items': items.map((Item item) => item.toJson()).toList(),
        },
      ),
    );
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return data['itemCount'] as int? ?? 0;
  }
}
