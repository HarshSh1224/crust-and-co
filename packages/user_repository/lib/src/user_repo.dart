import 'models/user_model.dart';

abstract class UserRepository{

  Stream<MyUser?> get user;

  Future<MyUser> signUp(MyUser myUser, String password);
  
  Future<void> signIn(String email, String password);
  
  Future<void> signOut();
  
  Future<void> setUserData(MyUser user);
}