import 'package:flutter/material.dart';
import 'package:local_storage_app/widgetss/text_widget.dart';

class UsersProfileScreenContainer extends StatefulWidget {
  final String title;
  final String detail;
  const UsersProfileScreenContainer({Key? key, required this.title, required this.detail, }) : super(key: key);

  @override
  State<UsersProfileScreenContainer> createState() => _UsersProfileScreenContainerState();
}

class _UsersProfileScreenContainerState extends State<UsersProfileScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20,right: 10,top: 15,bottom: 10),
        height: 60,
        width: 350,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade300,
                  Colors.lightBlueAccent.shade100,
                ]
            ),
            borderRadius: BorderRadius.only(bottomRight:Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,spreadRadius:0.5)
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: TextWidget(title: widget.title, detail: widget.detail)),
            ],
          ),
        )
    );
  }
}
