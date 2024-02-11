import 'package:chat_app/addroom/add_room.dart';
import 'package:chat_app/home/home_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  static const String routeScreen = 'homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigator{
  HomeViewModel viewModel=HomeViewModel();
  @override
  void initState() {

    super.initState();
    viewModel.navigator = this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>viewModel,
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
                'Chat App',
                style: TextStyle(fontSize: 24),
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(onPressed: (){
              Navigator.of(context).pushReplacementNamed(AddRoom.routename);
             },
              child: Icon(Icons.add),)
          ),
        ],
      ),
    );
  }
}
