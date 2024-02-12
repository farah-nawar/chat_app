import 'package:chat_app/chat/chat_navigator.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/myuser.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class ChatScreenViewModel extends ChangeNotifier{
late ChatNavigator navigator;
late MyUsers currentuser;
late Room room;
void sendMessage(String content){
  Message message= Message(
      dateTime: DateTime.now().millisecondsSinceEpoch,
      content: content,
      roomId: room.Roomid,
      senderId: currentuser.id,
      senderName: currentuser.username);
  try {
    var res = DatabaseUtils.InsertMessage(message);
    //clear message
    navigator.clearMessage();
  } catch(error){
     navigator.showMessage(error.toString());
  }
}



}