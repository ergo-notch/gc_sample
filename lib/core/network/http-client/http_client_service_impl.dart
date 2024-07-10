import 'package:dio/dio.dart';

import 'http_client_errors.dart';
import 'http_client_service.dart';

class HttpClientServiceImpl extends HttpClientService {
  final Dio dio;

  HttpClientServiceImpl({
    required this.dio,
  });

  @override
  Future post({
    required String path,
    required dynamic data,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response?.data.toString().contains('errors') ?? false) {
        throw HttpClientError(
            message: e.response?.data['errors'][0]['message'],
            statusCode: e.response?.statusCode);
      }
      if (e.type == DioExceptionType.connectionError) {
        throw HttpClientError(message: '${e.message}');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw HttpClientError(
            message: 'Por favor, revise su conexión a internet.');
      }
    }
  }

  @override
  Future get({
    required String path,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: params);
      return response.data;
    } on DioException catch (e) {
      if (e.response?.data.toString().contains('errors') ?? false) {
        throw HttpClientError(
            message: e.response?.data['errors'][0]['message'],
            statusCode: e.response?.statusCode);
      }
      if (e.type == DioExceptionType.connectionError) {
        throw HttpClientError(message: '${e.message}');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw HttpClientError(
            message: 'Por favor, revise su conexión a internet.');
      }
    }
  }
}
