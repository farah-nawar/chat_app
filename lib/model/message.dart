import 'dart:convert';

class Message {
  static const String collectionName='message';
  String id;
  String roomId;
  String content;
  String senderId;
  String senderName;
  int dateTime;

  Message(
      {this.id = '',
      required this.dateTime,
      required this.content,
      required this.roomId,
      required this.senderId,
      required this.senderName});


  Message.fromJson(Map<String,dynamic> json):this(
    id: json['id'] as String,
    roomId: json['roomId'] as String,
    content: json['content'] as String,
    senderId: json['senderid'] as String,
    senderName: json['sendername'] as String,
    dateTime: json['dateTime'] as int,
  );
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'roomId':roomId,
      'content':content,
      'senderid':senderId,
      'sendername':senderName,
      'dateTime':dateTime,
    };
  }

}
