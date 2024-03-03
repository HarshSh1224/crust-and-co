import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/constants/user_constants.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepo implements UserRepository{
  final _userCollection = FirebaseFirestore.instance.collection(UserConstants.userCollection);
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await _userCollection.doc(user.userId).set(user.toMap());
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
   try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
   } catch (error) {
      log(error.toString());
      rethrow;
   }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: myUser.email, password: password);
      
      myUser.userId = user.user!.uid;
      return myUser;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  @override
  Stream<MyUser> get user => _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
    if(firebaseUser == null){
      yield MyUser.empty;
    } else {
      yield await _userCollection
        .doc(firebaseUser.uid)
        .get()
        .then((value) => MyUser.fromMap(value.data()!));
    }
  });
}