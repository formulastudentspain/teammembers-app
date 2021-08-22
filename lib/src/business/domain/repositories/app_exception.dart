abstract class AppException implements Exception {
  String cause;
  AppException(this.cause);
}