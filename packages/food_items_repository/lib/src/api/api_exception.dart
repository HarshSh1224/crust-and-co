import 'package:food_repository/src/constants/repo_language.dart';

class ApiException implements Exception {
  String? message;
  int? code;

  ApiException({message, code}) {
    this.message = message ?? RepoLanguage.somethingWentWrong;
    this.code = code ?? 500;
  }

  @override
  String toString() {
    return 'ApiException{message: $message, code: $code}';
  }
}
