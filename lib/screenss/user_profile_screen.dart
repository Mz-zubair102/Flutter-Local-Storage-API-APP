import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../widgetss/user_profile_screen_container.dart';
import 'create_post.dart';

class UserProfileScreen extends StatefulWidget {
  final UserModel userdetail;
  const UserProfileScreen({Key? key, required this.userdetail})
      : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("USER: ${widget.userdetail.name}"),
        actions: [
          TextButton(onPressed: (){
            // objectBox.clearAllDB();
            setState(() {

            });
          }, child: Text("Clear",style: TextStyle(color: Colors.white),))
        ],
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
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
                      "User Info",
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
                SizedBox(
                  height: 5,
                ),
                UsersProfileScreenContainer(
                  title: "Name",
                  detail: "${widget.userdetail.name}",
                ),
                UsersProfileScreenContainer(
                  title: "Email",
                  detail: "${widget.userdetail.email}",
                ),
                UsersProfileScreenContainer(
                  title: "Username",
                  detail: "${widget.userdetail.username}",
                ),
                UsersProfileScreenContainer(
                  title: "Phone",
                  detail: "${widget.userdetail.phone}",
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Createpost(userdetail: widget.userdetail,)));
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context){return ValueScreen(countervalue: count);}));
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        elevation: 10,
                        backgroundColor: Colors.lightBlue,
                        shadowColor: Colors.red,
                        shape:BeveledRectangleBorder(
                          borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomLeft: Radius.circular(10)),
                        )
                    ),
                    child:Text("Crete Post",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                    ),)),
                SizedBox(
                  height: 15,
                ),
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
                      "Posts",
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
                SizedBox(
                  height: 5,
                ),
                /**ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount:objectBox.getAllPostOfUser(widget.userdetail.id).length,
                    itemBuilder: (context, index) {
                    PostModel userpostdetail = objectBox
                    .getAllPostOfUser(widget.userdetail.id)[index];
                    // PModel userpostdetail = objectBox
                    //     .getAllPostOfUserr(1)[index];

                    return InkWell(
                    onTap: () {},
                    child: Card(
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(userpostdetail.title),
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
                    Text(userpostdetail.body),
                    ],
                    ),
                    ),
                    ),
                    );
                    }),**/
                StreamBuilder<List<PostModel>>(
                    stream: objectBox.getAllPostOfUsersListStream(widget.userdetail.id),
                    builder: (context, AsyncSnapshot <List<PostModel>> snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            // itemCount:objectBox.getAllPostOfUser(widget.userdetail.id).length,
                            itemCount:snapshot.data!.length,
                            itemBuilder: (context, index) {
                              // PostModel userpostdetail = objectBox
                              //     .getAllPostOfUser(widget.userdetail.id)[index];
                              PostModel userpostdetail = snapshot.data![index];
                              // PModel userpostdetail = objectBox
                              //     .getAllPostOfUserr(1)[index];
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text(userpostdetail.title),
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
                                        Text(userpostdetail.body),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }else if(snapshot.hasError){
                        return Center(child: Text("${snapshot.error}"),);
                      }
                      else {
                        return Center(child: Text("Please wait"),);
                      }
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
