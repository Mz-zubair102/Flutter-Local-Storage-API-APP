
import 'package:flutter/material.dart';
import 'package:local_storage_app/screenss/post_list_screen.dart';
import 'package:local_storage_app/screenss/users_list_&_Posts_list_screen.dart';
import '../widgetss/button_widget.dart';

class ButtonScreen1 extends StatefulWidget {
  const ButtonScreen1({Key? key}) : super(key: key);

  @override
  State<ButtonScreen1> createState() => _ButtonScreen1State();
}

class _ButtonScreen1State extends State<ButtonScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Main Screen"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  iconss: Icon(Icons.account_circle_outlined,color:Colors.lightBlueAccent),
                  buttonname: "Users Screen",
                  onpressesd: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersListScreen()));
                  },
                ),
                ButtonWidget(
                  iconss: Icon(Icons.account_circle_outlined,color:Colors.lightBlueAccent
                  ),
                  buttonname:"Post List Screen",
                  onpressesd:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>PostsListScreen()));} ,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

