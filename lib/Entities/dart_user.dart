import 'package:firebase_auth/firebase_auth.dart';

class DartUser {
  late String id;

  DartUser.fromFirebase(User? user) {
    id = user!.uid;
  }
}
