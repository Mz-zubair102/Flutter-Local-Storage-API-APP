import 'package:flutter/material.dart';

class ClickButton extends StatefulWidget {
  final String title;
  final Icon icon1;

  final VoidCallback clicky;
  const ClickButton({Key? key,
    required this.title,

    required this.clicky, required this.icon1}) : super(key: key);

  @override
  State<ClickButton> createState() => _ClickButtonState();
}

class _ClickButtonState extends State<ClickButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.clicky,
      child: Container(
        width: 250,
        height: 65,
        decoration:  BoxDecoration(
          // border: Border.all(color: Colors.black),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade300,
              Colors.orange.shade200,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow:const [
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
        margin:EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.icon1,
                     SizedBox(width: 10,),
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black,
                            fontFamily: 'Rubik Regular'),
                      ),

                    ],
                  ),


                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
