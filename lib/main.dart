import 'package:chat_app/addroom/add_room.dart';
import 'package:chat_app/home/home_screen.dart';
import 'package:chat_app/login/login_screen.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context)=>UserProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userprovider=Provider.of<UserProvider>(context);
    return MaterialApp(
      initialRoute:userprovider.firebaseUser==null ? LoginScreen.routename : HomeScreen.routeScreen,
      routes: {
        RegisterScreen.routename: (context) => RegisterScreen(),
        LoginScreen.routename:(context) => LoginScreen(),
        HomeScreen.routeScreen:(context)=> HomeScreen(),
        AddRoom.routename:(context)=> AddRoom(),
      },
    );
  }
}
