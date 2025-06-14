import 'package:firebase_auth/firebase_auth.dart';

class AuthExceptionHandler implements Exception {
  final String message;
  AuthExceptionHandler(this.message);

  static AuthExceptionHandler handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return AuthExceptionHandler("Password is weak");
      case 'email-already-in-use':
        return AuthExceptionHandler('The account already exists.');
      case 'invalid-email':
        return AuthExceptionHandler('Email address is invalid.');
      case 'user-not-found':
        return AuthExceptionHandler('No user found for that email');
      case 'wrong-password':
        return AuthExceptionHandler('Wrong password provided for that user.');
      case 'invalid-credential':
        return AuthExceptionHandler("Email or password is invalid");
      default:
        return AuthExceptionHandler("An erorr has occured");
    }
  }

  @override
  String toString() => message;
}
