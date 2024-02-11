import 'package:chat_app/chat/chat_screen.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  RoomWidget({required this.room});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(ChatScreen.routename,arguments: room);
      },
      child: Container(
        margin: EdgeInsets.all(18),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(
              blurRadius: 7,
              color: Colors.grey,
              spreadRadius: 5)],

        ),
        child: Column(
          children: [
            Image.asset('assets/images/${room.categoryid}.png',
              height: 80,fit: BoxFit.fill,),
            Text(room.title),
          ],
        ),

      ),
    );
  }
}
