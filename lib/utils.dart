import 'package:flutter/material.dart';

void showloading( BuildContext context){

  showDialog(context: context,
      builder:(context){
       return AlertDialog(
         content: Row(
           children: [
             CircularProgressIndicator(),
             Text('Loading....')
           ],
         ),
        );
      }
  );
}
void hideloading( BuildContext context){
Navigator.pop(context);
}

void showMessage(BuildContext context, String message, String posActionText,Function posActionFun, {String? negActionText,Function? negActionFun}){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(onPressed: (){
          posActionFun(context);
        }, child: Text(posActionText))
      ],
    );
  });



}