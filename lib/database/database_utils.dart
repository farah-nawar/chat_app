import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/myuser.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*getusercollection() Function:

This is a static function that returns a reference to a Firestore collection of documents.
The collection() method is used to specify which collection you want to work with.
 In this case, it's using MyUsers.collectionName as the collection name.
.withConverter<MyUsers>() is used to specify a data converter for Firestore documents.
It tells Firestore how to convert between Firestore documents and Dart objects of type MyUsers.
This allows you to work with Dart objects directly when interacting with Firestore.
registeruser(MyUsers user) Function:

This is a static function that takes a MyUsers object called user as its parameter.
It first calls the getusercollection() function to get a reference to the Firestore collection where MyUsers data is stored.
.doc(user.id) is used to specify a document within the collection.
It assumes that each user's document has an id property that uniquely identifies the user.
.set(user) is used to set the data for the specified document.
It takes the user object and writes it to the Firestore database.
If a document with the same ID already exists, it will be updated with the new data.
If it doesn't exist, a new document will be created with the specified ID.
In summary, this code provides a way to register a user by storing their information in a Firestore collection named MyUsers.
It uses a MyUsers object for the user's data,
and the registeruser function adds or updates a a document in the collection with the user's data.

 */
class DatabaseUtils {
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

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter<Message>(
            fromFirestore: ((snapshot, options) =>
                Message.fromJson(snapshot.data()!)),
            toFirestore: (message, options) => message.toJson());
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

  static Stream<QuerySnapshot<Room>> getRooms() {
    return getRoomcollection().snapshots();
  }
  static Future<void> InsertMessage(Message message){
    var messageCollection= getMessageCollection(message.roomId);
    var docRef= messageCollection.doc();
    message.id= docRef.id;
    return docRef.set(message);

  }
  static Stream<QuerySnapshot<Message>> getMessages(String roomId){
    return getMessageCollection(roomId).orderBy('dateTime').snapshots();

  }
}
