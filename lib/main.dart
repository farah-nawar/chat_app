import 'package:chat_app/home/home_screen.dart';
import 'package:chat_app/login/login_screen.dart';
import 'package:chat_app/register/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:LoginScreen.routename,
      routes: {
        RegisterScreen.routename: (context) => RegisterScreen(),
        LoginScreen.routename:(context) => LoginScreen(),
        HomeScreen.routeScreen:(context)=> HomeScreen(),
      },
    );
  }
}
