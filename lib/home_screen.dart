import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = AuthClass().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text('Home Screen'),
        actions: [
          MaterialButton(
              onPressed: () async {
                await AuthClass().signOut();
              },
              child: Text('Signout', style: TextStyle(color: Colors.white)))
        ],
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1,
                      offset: Offset(3, 3),
                      color: Colors.grey.shade200)
                ]),
            child: Text(
                user!.email!.isEmpty ? 'No data' : user!.email.toString())),
      ),
    );
  }
}
