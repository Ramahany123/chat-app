import 'package:chat_app2/services/auth_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<void> registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionHandler.handleAuthException(e);
    } catch (e) {
      throw Exception("An error has occurred");
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionHandler.handleAuthException(e);
    } catch (e) {
      throw Exception("An error has occurred");
    }
  }
}
