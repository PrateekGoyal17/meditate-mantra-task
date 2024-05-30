import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meditate_mantra_task/auth/screens/login_screen.dart';
import 'package:meditate_mantra_task/auth/screens/pass_screen.dart';
import 'package:meditate_mantra_task/music/screens/loading_screen.dart';

class FirebaseService {
  BuildContext context;
  FirebaseService(this.context);
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> logIn(
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoadingScreen()),
          (Route route) => false);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        return 'Wrong password provided.';
      } else if (e.code == 'too-many-requests') {
        return 'too-many-requests';
      }
    }
    return "";
  }

  Future<User?> signUp(
    String email,
    String password,
  ) async {
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      user = auth.currentUser;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoadingScreen()),
          (Route route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  static Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  void forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PasswordScreen()));
  }

  void logout() async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}
