import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

import 'add_room_navigator.dart';

class AddRoomViewModel extends ChangeNotifier{
  late AddRoomNavigator navigator;
  void addRoom (String roomdescription, String roomtitle, String categoryId) async{
    Room room= Room(Roomid: '',
        title: roomtitle,
        description: roomdescription,
        categoryid: categoryId);
    try {
      navigator.showLoading();
      var CreatedRoom = await DatabaseUtils.addRoomtofirestore(room);
      navigator.hideLoading();
      navigator.showMessage('Room was added succesfully');
    }catch(e){
      navigator.hideLoading();
      navigator.showMessage(e.toString());
    }
  }

}