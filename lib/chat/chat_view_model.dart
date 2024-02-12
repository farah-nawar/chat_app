import 'package:chat_app/chat/chat_navigator.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/myuser.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreenViewModel extends ChangeNotifier {
  late ChatNavigator navigator;
  late MyUsers currentuser;
  late Room room;
  late Stream<QuerySnapshot<Message>> streamMessages;
  void sendMessage(String content) async {
    Message message = Message(
        dateTime: DateTime.now().millisecondsSinceEpoch,
        content: content,
        roomId: room.Roomid,
        senderId: currentuser.id,
        senderName: currentuser.username);
    try {
      var res = await DatabaseUtils.InsertMessage(message);
      //clear message
      navigator.clearMessage();
    } catch (error) {
      navigator.showMessage(error.toString());
    }
  }

  void listenforUpdateMessage() {
   streamMessages= DatabaseUtils.getMessages(room.Roomid);
  }
}
