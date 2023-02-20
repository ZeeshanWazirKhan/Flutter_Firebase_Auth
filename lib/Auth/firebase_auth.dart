import 'package:firebase_auth/firebase_auth.dart';

class AuthClass {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;
  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<void> signIn(email, password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> register(email, password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> sendVerificationEmail(emailAddress) async {
    try {
      await auth.sendPasswordResetEmail(email: emailAddress);
    } catch (e) {
      print(e);
    }
  }
}
