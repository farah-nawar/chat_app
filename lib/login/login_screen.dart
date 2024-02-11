import 'dart:async';

import 'package:chat_app/home/home_screen.dart';
import 'package:chat_app/login/login_navigator.dart';
import 'package:chat_app/login/login_view_model.dart';
import 'package:chat_app/model/myuser.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/register/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utils.dart' as Utils;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routename = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  var formkey = GlobalKey<FormState>();

  String email = '';

  String password = '';

  LoginViewModel viewModel = LoginViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'assets/images/main_background.png',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Login',
              style: TextStyle(fontSize: 24),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        onChanged: (text) {
                          email = text;
                        },
                        validator: (text) {
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text!);
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter your Email';
                          }
                          if (!emailValid) {
                            return 'please enter valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        onChanged: (text) {
                          password = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter your password';
                          }
                          if (text.length < 6) {
                            return 'password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text('Forgot Password?'),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          validateForm();
                        },
                        child: Text('Login'),
                      ),
                      SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routename);
                        },
                        child: Text('Create An Account'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void validateForm() async {
    if (formkey.currentState?.validate() == true) {
      viewModel.loginFirebaseAuth(email, password);
    }
  }

  @override
  void hideLoading() {
    Utils.hideloading(context);
  }

  @override
  void showLoading() {
    Utils.showloading(context);
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, 'ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void navigateToHome(MyUsers users) {
    var userProvider= Provider.of<UserProvider>(context,listen: false);
    userProvider.users = users;
    Timer(
      Duration(seconds: 5),
          () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeScreen);
      },
    );
  }

}
