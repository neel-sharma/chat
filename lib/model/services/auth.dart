import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:chat/model/user_id.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserID? _userFromFirebaseUser(User? user) {
    return user != null ? UserID(id: user.uid) : null;
  }

  Stream<UserID?> get user {
    return auth.authStateChanges().map(_userFromFirebaseUser);
  }

  bool isEmailVerified() {
    auth.currentUser!..reload();
    User user = auth.currentUser!;
    bool status = user.emailVerified;
    print(user.toString());
    print(status);
    return status;
  }

  String getCurrentUID() {
    final User user = auth.currentUser!;
    final String uid = user.uid;
    return uid;
  }

  String getCurrentEmail() {
    final User user = auth.currentUser!;
    final String email = user.email!;
    return email;
  }

  Future signInWithEmailAndPassword(String mail, String pass) async {
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = userCredential.user!;

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
    }
  }

  sendConfirmationMail() async {
    final User user = auth.currentUser!;
    await user.sendEmailVerification();
  }

  Future signUpWithEmailAndPassword(
      BuildContext context, String mail, String pass) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: mail, password: pass);
      User user = userCredential.user!;
      await user.sendEmailVerification();

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'tooweak';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'emailused';
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String mail) async {
    auth.sendPasswordResetEmail(email: mail);
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  final TextEditingController _tokenController = TextEditingController();

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return auth.signInWithCredential(googleAuthCredential);
    } catch (e) {
      print(e);
      print('Failed to sign in with Google: $e');
      return null;
    }
  }

  Future signInWithFacebook() async {
    final plugin = FacebookLogin(debug: true);
    try {
      await plugin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      final token = await plugin.accessToken;

      final credential = FacebookAuthProvider.credential(token.toString());

      return auth.signInWithCredential(credential);

      //await _updateLoginInfo();
    } catch (e) {
      print(e);
      print('Failed to sign in with Facebook: $e');
      return null;
    }
  }
}
