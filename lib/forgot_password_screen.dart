import 'package:firebase_crud_app/Auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = '';

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(21),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Reset Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 21),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      'Enter the email so we can send reset password option to it.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    SizedBox(
                      height: 41,
                    ),
                    emailField(),
                    SizedBox(
                      height: 11,
                    ),
                    sendVerificationEmailButton(context)
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget emailField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      cursorColor: Colors.purple.shade400,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple.shade400)),
          hintText: 'Enter email...',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
    );
  }

  Widget sendVerificationEmailButton(context) {
    return Padding(
      padding: EdgeInsets.only(top: 21, bottom: 21),
      child: MaterialButton(
          onPressed: email.isEmpty
              ? null
              : () async {
                  showLoading = true;
                  AuthClass().sendVerificationEmail(email).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Email sent'),
                      backgroundColor: Colors.purple,
                    ));
                  });
                },
          padding: EdgeInsets.symmetric(vertical: 13),
          minWidth: double.infinity,
          color: Colors.purple.shade300,
          disabledColor: Colors.grey.shade300,
          textColor: Colors.white,
          child: showLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text('Send Verification Email')),
    );
  }
}
