import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_app/Auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgot_password_screen.dart';

class LoginAndRegisterScreen extends StatefulWidget {
  const LoginAndRegisterScreen({super.key});
  @override
  State<LoginAndRegisterScreen> createState() => _LoginAndRegisterScreenState();
}

class _LoginAndRegisterScreenState extends State<LoginAndRegisterScreen> {
  bool loginScreenVisible = true;
  bool showLoading = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(loginScreenVisible ? 'Login' : 'Signup'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 200),
        child: Column(
          children: [
            inputField('email'),
            inputField('password'),
            !loginScreenVisible ? SizedBox() : forgotPassword(),
            loginRegisterButton(),
            toggleIconButton()
          ],
        ),
      ),
    );
  }

  /// Flutter textfield ///
  Widget inputField(fieldType) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        onChanged: (value) {
          setState(() {
            if (fieldType == 'email') {
              email = value;
            }
            if (fieldType == 'password') {
              password = value;
            }
          });
        },
        cursorColor: Colors.purple.shade400,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple.shade400)),
            hintText:
                fieldType == 'email' ? 'Enter email...' : 'Enter password...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
      ),
    );
  }

  /// Forgot password ///
  Widget forgotPassword() {
    return Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ForgotPasswordScreen()));
          },
          child: Text(
            'Forgot password?',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 13),
          ),
        ));
  }

  /// Login and Register Button
  Widget loginRegisterButton() {
    return Padding(
      padding: EdgeInsets.only(top: 31, bottom: 21),
      child: MaterialButton(
          onPressed: email.isEmpty || password.isEmpty
              ? null
              : () async {
                  setState(() {});
                  showLoading = true;
                  if (loginScreenVisible) {
                    try {
                      await AuthClass().signIn(email, password);
                      print('get it');
                    } on FirebaseAuthException catch (e) {
                      if (AuthClass().currentUser == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Invalid email or password')));
                      }
                    }
                    setState(() {
                      showLoading = false;
                    });
                  }
                  if (!loginScreenVisible) {
                    try {
                      await AuthClass().register(email, password);
                    } on FirebaseAuthException catch (e) {
                      var res = await AuthClass()
                          .auth
                          .fetchSignInMethodsForEmail(email);
                      if (res.isNotEmpty)
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User already exists')));
                    }
                    setState(() {
                      showLoading = false;
                    });
                  }
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
              : Text(loginScreenVisible ? 'Login' : 'Register')),
    );
  }

  /// custom toggle button ///
  Widget toggleIconButton() {
    return InkWell(
      onTap: () {
        setState(() {
          loginScreenVisible = !loginScreenVisible;
        });
      },
      child: Container(
        padding: EdgeInsets.all(5),
        height: 50,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            loginScreenVisible
                ? toggleButtonText()
                : Expanded(
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
            !loginScreenVisible
                ? toggleButtonText()
                : Expanded(
                    child: Center(
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget toggleButtonText() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.purple.shade300),
        child: Text(
          loginScreenVisible ? 'Login' : 'Signup',
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }
}
