import 'package:user_repository/src/models/user_model.dart';

abstract class UserRepository {
  Future<bool> signIn(String email, String password);

  Future<bool> signUp(MyUser user, String password);

  Future<bool> trySignIn();

  Future<void> signOut();

  MyUser get currentUser;
}
