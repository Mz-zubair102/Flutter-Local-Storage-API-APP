import 'package:flutter/material.dart';
import 'package:local_storage_app/AB_DATA/ab_screens/home_screen.dart';
import 'package:local_storage_app/AB_DATA/ab_screens/user_button_screen.dart';

import '../../models/user_model.dart';
import '../ab_widget/click_button.dart';

class ButtonScreen extends StatefulWidget {

  const ButtonScreen({Key? key,}) : super(key: key);

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Button Screen',style: TextStyle(
          fontSize: 22,
          color: Colors.black,
          fontWeight: FontWeight.w500,

        ),),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClickButton(
                title: 'POST',
                icon1: Icon(Icons.post_add,color: Colors.black,size: 30,),
                clicky: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                }),

            Padding(
              padding: const EdgeInsets.only(left: 85),
              child: ClickButton(
                  title: 'COMMENTS',
                  icon1: Icon(Icons.comment_outlined,color: Colors.black,size: 30,),
                  clicky: (){
                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=> CoomentScreen()));
                  }),
            ),
            ClickButton(
                title: 'ALBUMS',
                icon1: Icon(Icons.album_outlined,color: Colors.black,size: 30,),
                clicky: (){
              //    Navigator.push(context, MaterialPageRoute(builder: (context)=> AlbumScreen()));
                }),
            Padding(
              padding: const EdgeInsets.only(left: 85),
              child: ClickButton(
                  title: 'PHOTOS',
                  icon1: Icon(Icons.photo,color: Colors.black,size: 30,),
                  clicky: (){
                 //   Navigator.push(context, MaterialPageRoute(builder: (context)=> PostScreen()));
                  }),
            ),
            ClickButton(
                title: 'USERS',
                icon1: Icon(Icons.supervised_user_circle,color: Colors.black,size: 30,),
                clicky: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> UserButtonScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
