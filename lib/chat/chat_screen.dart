import 'package:chat_app/chat/chat_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/room.dart';
import 'chat_view_model.dart';

class ChatScreen extends StatefulWidget {
  static const String routename = 'chat';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatScreenViewModel viewModel = ChatScreenViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
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
                args.title,
                style: TextStyle(fontSize: 24),
              ),
              centerTitle: true,
            ),
            body: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              hintText: 'Type a message',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12)))),
                        ),),
                      SizedBox(width: 8,),
                      ElevatedButton(onPressed: (){},
                          child: Row(
                            children: [
                              Text('Send'),
                              Icon(Icons.send),
                            ],
                          ))

                    ],
                  )
                ],
              ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void clearMessage() {
    // TODO: implement clearMessage
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
  }
}