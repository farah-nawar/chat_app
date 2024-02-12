import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget({required this.message});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.users?.id == message.senderId
        ? SentMessage(message: message)
        : RecievedMessage(message: message);
  }
}

class SentMessage extends StatelessWidget {
  Message message;
  SentMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    return Column(
crossAxisAlignment: CrossAxisAlignment.end
      ,      children: [
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              color: Colors.blue),
          child: Text(message.content,
    style: TextStyle(color: Colors.white)),
        ),
        Text(
          message.dateTime.toString(),
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}

class RecievedMessage extends StatelessWidget {
  Message message;
  RecievedMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: Colors.grey),
          child: Text(message.content,
              style: TextStyle(color: Colors.white)),
        ),

        Text(
          message.dateTime.toString(),
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}
