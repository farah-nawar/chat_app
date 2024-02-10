import 'package:chat_app/firebase_errors.dart';
import 'package:chat_app/home/home_screen.dart';
import 'package:chat_app/register/register_navigator.dart';
import 'package:chat_app/register/register_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:chat_app/utils.dart' as Utils;

import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routename = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator{
  String firstname = '';

  String lastname = '';

  String email = '';

  String password = '';

  String username = '';

  var formkey = GlobalKey<FormState>();
  RegisterViewModel viewModel = RegisterViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> viewModel,
      child: Stack(
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
                'Create Account',
                style: TextStyle(fontSize: 24),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'First Name',
                      ),
                      onChanged: (text) {
                        firstname = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter your firstname';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                      ),
                      onChanged: (text) {
                        lastname = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter your last name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'User Name',
                      ),
                      onChanged: (text) {
                        username = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter your username';
                        }
                        return null;
                      },
                    ),
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
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        validateForm();
                      },
                      child: Text('Create Account'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateForm() async {
    if (formkey.currentState?.validate() == true) {
        viewModel.registerfirebaseAuth(email, password);
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
    Utils.showMessage(context, message, 'OK', (context){
      Navigator.of(context).pushNamed(HomeScreen.routeScreen);
    });
  }
  
}
