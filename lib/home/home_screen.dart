import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeScreen='homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    'Chat App',
    style: TextStyle(fontSize: 24),
    ),
    centerTitle: true,
    ),
    ),
      ],
    );
  }
}
