import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


import '../main.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../widgetss/text_field.dart';
import '../widgetss/text_widget.dart';

class Createpost extends StatefulWidget {
  final UserModel userdetail;
  const Createpost({Key? key, required this.userdetail}) : super(key: key);
  @override
  State<Createpost> createState() => _CreatepostState();
}

class _CreatepostState extends State<Createpost> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController bodycontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("USER: ${widget.userdetail.name}"),
        backgroundColor: Colors.cyan,
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                              title: "Name", detail: widget.userdetail.name),
                          SizedBox(
                            height: 5,
                          ),
                          TextWidget(
                              title: "Email", detail: widget.userdetail.email),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextInputField(
                    hinttext: "Post Title",
                    label: "Post Title...",
                    mycontroller: titlecontroller,
                    // Validator: (String? input){
                    //   if (input == null || input.isEmpty) {
                    //     return "Title is required";
                    //   } else if ((!RegExp(r'^[a-z A-Z]+$').hasMatch(input))) {
                    //     return 'Please Enter only Alphabets ';
                    //   }
                    //   return null;
                    // },
                    istitle: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextInputField(
                    hinttext: "Post Body",
                    label: "Post Body...",
                    mycontroller: bodycontroller,
                    isbody: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          PostModel detail= PostModel.autoId(userId: widget.userdetail.id, title: titlecontroller.text, body: bodycontroller.text);
                          objectBox.insertPostModel(detail);
                          print("Post Count:${objectBox.getPostModelCount()}");
                          setState(() {
                          });
                          // // PModel detail= PModel.autoId(userId: widget.userdetail.id, title: titlecontroller.text, body: bodycontroller.text);
                          // PModel detail=PModel(id:widget.userdetail.id,userId: widget.userdetail.id, title: titlecontroller.text, body: bodycontroller.text);
                          // objectBox.insertPModel(detail);
                          // print("Post Count:${objectBox.getPModelCount()}");
                          // setState(() {
                          // });

                          var snackBar = SnackBar(
                            content: Text("Successfully data is transferred"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.of(context).pop();
                          // bool status = await objectBox.insertPostModel(detail);
                          // status
                          //     ? showDialog<void>(
                          //   context: context,
                          //   barrierDismissible:
                          //   false, // user must tap button!
                          //   builder: (BuildContext context) {
                          //     return AlertDialog(
                          //       title: const Text('AlertDialog'),
                          //       content: SingleChildScrollView(
                          //         child: ListBody(
                          //           children: <Widget>[
                          //             Text("Name : ${titlecontroller.text}"),
                          //             Text('Body: ${bodycontroller.text}'),
                          //           ],
                          //         ),
                          //       ),
                          //       actions: <Widget>[
                          //         TextButton(
                          //           child: const Text('Cancel'),
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //         ),
                          //         TextButton(
                          //           child: const Text('Approve'),
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //             // Navigator.of(context).pop();
                          //           },
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // )
                          //     : Text("Failed");
                        }
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          elevation: 15,
                          backgroundColor: Colors.cyan,
                          shadowColor: Colors.red,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          )),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
