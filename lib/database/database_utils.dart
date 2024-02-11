import 'package:chat_app/model/myuser.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtils{

    static CollectionReference<MyUsers> getusercollection() {
      //collection is where we store this data
      return FirebaseFirestore.instance
          .collection(MyUsers.collectionName)
          .withConverter<MyUsers>(
          fromFirestore: ((snapshot, options) =>
              MyUsers.fromJson(snapshot.data()!)),
          toFirestore: (user, options) => user.toJson());
    }
    static CollectionReference<Room> getRoomcollection() {
      //collection is where we store this data
      return FirebaseFirestore.instance
          .collection(Room.collectionName)
          .withConverter<Room>(
          fromFirestore: ((snapshot, options) =>
              Room.fromJson(snapshot.data()!)),
          toFirestore: (room, options) => room.toJson());
    }

    static Future<void> registeruser(MyUsers user) async {
      return getusercollection().doc(user.id).set(user);
    }
    // function used in provider to get current user
    static Future<MyUsers?> getUser(String userId) async {
      var documentsnapshot = await getusercollection().doc(userId).get();
      return documentsnapshot.data();
    }

    static Future<void> addRoomtofirestore(Room room) async {
      var query = await getRoomcollection().doc();
      room.Roomid = query.id;
      return query.set(room);
    }

  }

