import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/post_model.dart';
class PostsListScreen extends StatefulWidget {
  const PostsListScreen({Key? key}) : super(key: key);

  @override
  State<PostsListScreen> createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  /**Future<List<PModel>> getPostList() async {
      List<PModel> postlist = [];
      if (objectBox.getPModelCount() >= 1) {
      print('Data from Object Box of pm');
      return objectBox.getAllPModel();
      }
      //1-convert URL to Uri
      Uri uri = Uri.parse(
      "https://jsonplaceholder.typicode.com/posts");
      //2-Use Uri to call Api
      http.Response response = await http.get(uri);
      //3-Decode Response body
      var decodebody = jsonDecode(response.body) as List;
      postlist =
      List<PModel>.from(decodebody.map((json) => PModel.fromJson(json)))
      .toList();
      objectBox.insertAllPModel(postlist);
      print('Data from API of pm');
      return postlist;
      }**/
  Future<List<PostModel>> getPostList()async{
    List<PostModel> list=[];

    if(objectBox.getPostModelCount()>=1){
      print("Data from Object Box of post");
      return objectBox.getAllPostModel();
    }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("POSTS LIST Screen"),
          backgroundColor: Colors.cyan,
          actions: [
            TextButton(onPressed: (){
              // objectBox.clearAllDB();
              setState(() {

              });
            }, child: Text("Clear",style: TextStyle(color: Colors.white),))
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
                /** FutureBuilder<List<PModel>>(
                    future: getPostList(),
                    builder: (BuildContext context,
                    AsyncSnapshot<List<PModel>> snapshot) {
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
                    PModel? postsdetail = snapshot.data![index];
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
                    ;
                    },
                    )**/
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
