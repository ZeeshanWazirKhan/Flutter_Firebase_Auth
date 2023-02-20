import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_app/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Auth/firebase_auth.dart';
import 'home_screen.dart';
import 'login_register_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Firebase Auth App',
        home: ChooseScreen());
  }
}

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthClass().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginAndRegisterScreen();
        }
      },
    );
  }
}



//// home screen ///



