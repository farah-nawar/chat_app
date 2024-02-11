// save the user in my application

import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/myuser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUsers? users;
  User? firebaseUser;

  UserProvider(){
    firebaseUser= FirebaseAuth.instance.currentUser;
    initUser();
  }

  initUser() async{
    if(firebaseUser !=null){
      users= await DatabaseUtils.getUser(firebaseUser?.uid ?? '');
    }
  }





}