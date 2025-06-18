import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClientService {
  ApiClientService() {
    unawaited(setup());
  }

  Dio dio = Dio(
    BaseOptions(
      baseUrl: _ServiceConstants.baseUrl,
      contentType: "application/json",
      headers: {"Accept": "application/json"},
      connectTimeout: const Duration(seconds: 40),
      receiveTimeout: const Duration(seconds: 40),
    ),
  );

  Future<void> setup() async {
    final Interceptors interceptors = dio.interceptors;

    interceptors.clear();

    final LogInterceptor logInterceptor = LogInterceptor(
      requestBody: true,
      responseBody: true,
    );

    final QueuedInterceptorsWrapper headerInterceptors =
        QueuedInterceptorsWrapper(
          onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) =>
                  handler.next(options),
          onError: (DioException error, ErrorInterceptorHandler handler) {
            handler.next(error);
          },
          onResponse:
              (Response response, ResponseInterceptorHandler handler) =>
                  handler.next(response),
        );
    interceptors.addAll([if (kDebugMode) logInterceptor, headerInterceptors]);
  }
}

class _ServiceConstants {
  static const baseUrl = 'https://dummyjson.com/';
}
