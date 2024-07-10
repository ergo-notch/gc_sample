class HttpClientError implements Exception {
  final String message;
  final int? statusCode;

  HttpClientError({required this.message, this.statusCode});
}
