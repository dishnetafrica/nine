import 'package:dio/dio.dart';

import '../constants/app_constants.dart';

class ApiClient {
  ApiClient({required Dio dio}) : _dio = dio {
    _dio
      ..options.connectTimeout =
          const Duration(seconds: AppConstants.defaultRequestTimeoutSeconds)
      ..options.receiveTimeout =
          const Duration(seconds: AppConstants.defaultRequestTimeoutSeconds)
      ..interceptors.add(
        InterceptorsWrapper(
          onError: (error, handler) async {
            final req = error.requestOptions;
            final retries = (req.extra['retries'] as int?) ?? 0;
            if (retries < AppConstants.maxRetryAttempts) {
              req.extra['retries'] = retries + 1;
              await Future<void>.delayed(Duration(milliseconds: 400 * (retries + 1)));
              final response = await _dio.fetch(req);
              return handler.resolve(response);
            }
            return handler.next(error);
          },
        ),
      );
  }

  final Dio _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
  }) {
    return _dio.get<T>(path, queryParameters: query, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Options? options,
  }) {
    return _dio.post<T>(path, data: data, options: options);
  }
}
