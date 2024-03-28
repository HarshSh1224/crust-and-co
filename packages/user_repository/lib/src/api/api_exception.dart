class ApiException implements Exception {
  String? message;
  int? code;

  ApiException({message, code}) {
    this.message = message ?? "Something went wrong";
    this.code = code ?? 500;
  }

  @override
  String toString() {
    return 'ApiException{message: $message, code: $code}';
  }
}
