import 'dart:convert';
import 'package:local_storage_app/screenss/user_profile_screen.dart';
import 'package:objectbox/objectbox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../widgetss/text_widget.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  List<UserModel> userlist = [];
  Future<List<UserModel>> getUser() async {
    if (objectBox.getUserModelCount() >= 1) {
      print('Data from Object Box of user');
      return objectBox.getAllUserModel();
    }
    Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    http.Response response = await http.get(uri);
    var decodeBody = jsonDecode(response.body) as List;
    userlist = List<UserModel>.from(
        decodeBody.map((jason) => UserModel.fromJson(jason))).toList();
    objectBox.insertAllUserModel(userlist);
    print('Data from API of user');
    return userlist;
  }
  // Future<List<PostModel>> getPostList() async {
  //   List<PostModel> postlist = [];
  //   if (objectBox.getPostModelCount() >= 1) {
  //     print('Data from Object Box of post');
  //     return objectBox.getAllPostModel();
  //   }
  //   //1-convert URL to Uri
  //   Uri uri = Uri.parse(
  //       "https://jsonplaceholder.typicode.com/posts");
  //   //2-Use Uri to call Api
  //   http.Response response = await http.get(uri);
  //   //3-Decode Response body
  //   var decodebody = jsonDecode(response.body) as List;
  //   postlist =
  //       List<PostModel>.from(decodebody.map((json) => PostModel.fromJson(json)))
  //           .toList();
  //   // objectBox.insertAllPostModel(postlist);
  //   print('Data from API of post');
  //   return postlist;
  // }
  Future<List<PostModel>> getPostList()async{
    List<PostModel> list=[];

    if(objectBox.getPostModelCount()>=1){
      print("Data from Object Box of post");
      return objectBox.getAllPostModel();
    }else{
      Uri uri=Uri.parse("https://jsonplaceholder.typicode.com/posts");
      http.Response response=await http.get(uri);
      if(response.statusCode==200){
        var decodedBody=jsonDecode(response.body);
        list=List<PostModel>.from(decodedBody.map((json)=>PostModel.fromJson(json))).toList();
      }
      objectBox.insertAllPostModel(list);
      print("Data from API");
      return list;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("USERS LIST & POST LIST"),
          backgroundColor: Colors.cyan,
          actions: [
            // TextButton(onPressed: (){
            //   objectBox.clearAllDB();
            //   setState(() {
            //
            //   });
            // }, child: Text("Clear",style: TextStyle(color: Colors.white),))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                          thickness: 3,
                          color: Colors.cyan,
                          height: 4,
                          endIndent: 5,
                        )),
                    Text(
                      "Users List",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Divider(
                          indent: 5,
                          thickness: 3,
                          color: Colors.cyan,
                          height: 4,
                        )),
                  ],
                ),
                FutureBuilder<List<UserModel>>(
                    future: getUser(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<UserModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              UserModel? userdetail = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserProfileScreen(
                                                  userdetail: userdetail)));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 15, bottom: 10),
                                  height: 90,
                                  width: 380,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.grey.shade300,
                                            Colors.lightBlueAccent.shade100,
                                          ]),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3,
                                            spreadRadius: 0.5)
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                  title: "Name",
                                                  detail: userdetail.name),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextWidget(
                                                  title: "Email",
                                                  detail: userdetail.email)
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.grey.shade600,
                                          size: 32,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Center(child: Text("${snapshot.error}"));
                      } else {
                        return Center(child: Text("Please Wait"));
                      }
                    }),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                          thickness: 3,
                          color: Colors.cyan,
                          height: 4,
                          endIndent: 5,
                        )),
                    Text(
                      "Posts List",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Divider(
                          indent: 5,
                          thickness: 3,
                          color: Colors.cyan,
                          height: 4,
                        )),
                  ],
                ),
                // FutureBuilder<List<PostModel>>(
                //   future: getPostList(),
                //   builder: (BuildContext context,
                //       AsyncSnapshot<List<PostModel>> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     } else if (snapshot.hasData) {
                //       return ListView.builder(
                //           physics: ScrollPhysics(),
                //           shrinkWrap: true,
                //           itemCount: snapshot.data!.length,
                //           itemBuilder: (Context, int index) {
                //             PostModel? postsdetail = snapshot.data![index];
                //             return GestureDetector(
                //               onTap: () {},
                //               child: Card(
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.start,
                //                     crossAxisAlignment:
                //                     CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         "Title :",
                //                         style: TextStyle(
                //                             fontSize: 16,
                //                             fontWeight: FontWeight.bold,
                //                             color: Colors.lightBlue),
                //                       ),
                //                       SizedBox(
                //                         height: 5,
                //                       ),
                //                       Text(postsdetail.title),
                //                       SizedBox(
                //                         height: 5,
                //                       ),
                //                       Text(
                //                         "Body Detail :",
                //                         style: TextStyle(
                //                             fontSize: 16,
                //                             fontWeight: FontWeight.bold,
                //                             color: Colors.lightBlue),
                //                       ),
                //                       SizedBox(
                //                         height: 5,
                //                       ),
                //                       Text(postsdetail.body),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             );
                //           });
                //     } else if (snapshot.hasError) {
                //       return Center(
                //         child: Text("${snapshot.error}"),
                //       );
                //     } else {
                //       return Center(
                //         child: Text("Please wait"),
                //       );
                //     }
                //     ;
                //   },
                // )
                StreamBuilder<List<PostModel>>(
                    stream: objectBox.getPostOfListStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (Context, int index) {
                              PostModel? postsdetail = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Title :",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlue),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(postsdetail.title),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Body Detail :",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlue),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(postsdetail.body),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      } else {
                        return Center(
                          child: Text("Please wait"),
                        );
                      }
                    }
                )
              ],
            ),
          ),
        ));
  }
}
