class ServerException implements Exception {
  final String message;
  ServerException({this.message = 'Something went wrong'});
  @override
  String toString() => message;
}