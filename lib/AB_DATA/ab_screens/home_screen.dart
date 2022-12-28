import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_storage_app/main.dart';
import 'package:local_storage_app/models/post_model.dart';
import '../../models/user_model.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel> userlist = [];
  List<PostModel> postlist = [];

  Future<List<UserModel>> getUserData() async {

    Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var decodebody = jsonDecode(response.body) as List;
      userlist = List<UserModel>.from(
          decodebody.map((json) => UserModel.fromJson(json))).toList();
    }
    return userlist;
  }

 //  Isma data check hu ga kh agr data 1 sa zyada ha to getAllPostModel call hu jaye ga
  // agr data 1 sa km ha tu vo URI ma chala jaye ga ur list banye ga ur dubara insertAllPostModel call hu jaye ga
  // ur postlist uska andr daal dain ga

  Stream<List<PostModel>> getPostData() async* {
    if (objectBox.getPostModelCount() >= 1) {
      print('Data From Object Box');
    yield objectBox.getAllPostModel();
    }
    else {
      Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        var decodebody = jsonDecode(response.body) as List;
        postlist = List<PostModel>.from(
            decodebody.map((json) => PostModel.fromJson(json))).toList();
      }
      objectBox.insertAllPostModel(postlist);
      print('Data from API');

    }
   yield postlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<UserModel>>(
                future: getUserData(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          UserModel? detail = snapshot.data![index];
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
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(detail.name),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "Email",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(detail.email),
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



              StreamBuilder<List<PostModel>>(
                stream: objectBox.getPostOfListStream(),
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
