import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_storage_app/main.dart';
import 'package:local_storage_app/AB_DATA/ab_screens/user_info_screen.dart';
import '../../models/user_model.dart';

class UserButtonScreen extends StatefulWidget {
  const UserButtonScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserButtonScreen> createState() => _UserButtonScreenState();
}

class _UserButtonScreenState extends State<UserButtonScreen> {

  List<UserModel> userlist = [];

  Future<List<UserModel>> getUser() async {
    if (objectBox.getUserModelCount() >= 1) {
      print('Object Sa data a raha');
      return objectBox.getAllUserModel();
    }
    Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    http.Response response = await http.get(uri);
    var decodeBody = jsonDecode(response.body) as List;
    userlist = List<UserModel>.from(
        decodeBody.map((jason) => UserModel.fromJson(jason))).toList();
    objectBox.insertAllUserModel(userlist);
    print('data from user model');
    return userlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<UserModel>>(
        future: getUser(),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                UserModel userdetail = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserInfoScreen(userinfo: userdetail)));
                    },
                    child: Container(
                      width: 380,
                      height: 100,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.blue.shade300,
                            Colors.white,
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.5, // soften the shadow
                            spreadRadius: 0.5, //extend the shadow
                            offset: Offset(
                              0.5, // Move to right 5  horizontally
                              0.5, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  userdetail.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Rubik Regular'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(userdetail.email),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.hasError}"),
            );
          } else {
            return Text('Please Wait....');
          }
        },
      ),
    );
  }
}
