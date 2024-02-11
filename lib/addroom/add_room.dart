import 'package:chat_app/addroom/add_room_navigator.dart';
import 'package:chat_app/addroom/add_room_view_model.dart';
import 'package:chat_app/model/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utils.dart' as Utils;

class AddRoom extends StatefulWidget {
  static const String routename = 'room';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigator {
  AddRoomViewModel viewModel = AddRoomViewModel();
  String roomTitle = '';
  String roomDescription = '';
  var formkey = GlobalKey<FormState>();
  var CategoryList = Category.getCategory();
  Category? selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Chat App',
                style: TextStyle(fontSize: 24),
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Create New Room',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Image.asset('assets/images/group.png'),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Enter Room Name'),
                        onChanged: (text) {
                          text = roomTitle;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter room name';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownButton<Category>(
                        value: selectedItem,
                        items: CategoryList.map(
                            (category) => DropdownMenuItem<Category>(
                                value: category,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(category.title),
                                    Image.asset(category.image)
                                  ],
                                ))).toList(),
                        onChanged: (newcategory) {
                          if (newcategory == null) {
                            return;
                          }
                          selectedItem = newcategory;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: 'Enter Room Description'),
                        onChanged: (text) {
                          text = roomDescription;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter room Description';
                          }
                        },

                      ),
                      SizedBox(height: 25),
                        // Adjust the width as needed
                        ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          style: ButtonStyle(
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Adjust the radius for circular edges
                              ),
                            ),
                          ),
                          child: Text('Create'),
                        ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateForm() {
    if (formkey.currentState?.validate() == true) {
      //add room
      viewModel.addRoom(roomDescription, roomTitle, selectedItem!.id);
    }
  }

  @override
  void hideLoading() {
    Utils.hideloading(context);
  }

  @override
  void navigateToHome() {
    // TODO: implement navigateToHome
  }

  @override
  void showLoading() {
    Utils.showloading(context);
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, 'ok', (context) {
      Navigator.pop(context);
    });
  }
}
