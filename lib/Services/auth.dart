import 'package:firebase_auth/firebase_auth.dart';
import 'package:rate_your_music/Entities/dart_user.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<DartUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return DartUser.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future<DartUser?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return DartUser.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await firebaseAuth.signOut();
  }

  Stream<DartUser?> get currentUser {
    return firebaseAuth
        .authStateChanges()
        .map((User? user) => user != null ? DartUser.fromFirebase(user) : null);
  }
}
