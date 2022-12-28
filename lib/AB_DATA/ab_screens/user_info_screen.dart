import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_storage_app/main.dart';
import 'package:local_storage_app/AB_DATA/ab_screens/insert_screen.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../ab_widget/text_display.dart';

class UserInfoScreen extends StatefulWidget {
  final UserModel userinfo;
  const UserInfoScreen({Key? key, required this.userinfo}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
              text: 'Profile Screen of: ',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: widget.userinfo.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ]),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    TextDisplay(title: 'Name = ', deatil: widget.userinfo.name),
                    const SizedBox(
                      height: 10,
                    ),
                    TextDisplay(
                      title: 'Email = ',
                      deatil: widget.userinfo.email,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextDisplay(
                        title: 'Phone Number = ',
                        deatil: widget.userinfo.phone),
                    const SizedBox(
                      height: 10,
                    ),
                    TextDisplay(
                        title: 'User Name = ',
                        deatil: widget.userinfo.username),
                    const SizedBox(
                      height: 10,
                    ),
                    TextDisplay(
                        title: 'Website = ', deatil: widget.userinfo.website),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InsertPostScreen(
                                  id: widget.userinfo.id,
                                )));
                  },
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue.shade300,
                          Colors.white,
                        ],
                      ),
                      border: Border.all(
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                    ),
                    child: const Center(
                      child: Text(
                        'Create post',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),

              // ListView.builder(
              //     shrinkWrap: true,
              //     physics: const ScrollPhysics(),
              //     itemCount:
              //         objectBox.getAllPostOfUser(widget.userinfo.id).length,
              //     itemBuilder: (context, index) {
              //       PostModel? detail =
              //           objectBox.getAllPostOfUser(widget.userinfo.id)[index];
              //       return InkWell(
              //         onTap: () {},
              //         child: Card(
              //           color: Colors.blue.shade100,
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   "Title :",
              //                   style: TextStyle(
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.blueAccent),
              //                 ),
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 Text(detail.title),
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 const Text(
              //                   "Body Detail :",
              //                   style: TextStyle(
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.blueAccent),
              //                 ),
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 Text(detail.body),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     }),

              StreamBuilder<List<PostModel>>(
                stream: objectBox.getAllPostOfUsersListStream(widget.userinfo.id),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PostModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          PostModel? detailofPost = snapshot.data![index];
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              color: Colors.blue.shade100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Title",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(detailofPost.title),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "Body",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(detailofPost.body),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
