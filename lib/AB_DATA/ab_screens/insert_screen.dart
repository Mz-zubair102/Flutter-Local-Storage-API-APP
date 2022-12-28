import 'package:flutter/material.dart';
import 'package:local_storage_app/main.dart';
import 'package:local_storage_app/models/post_model.dart';

import '../ab_widget/text_field.dart';

class InsertPostScreen extends StatefulWidget {
  final int id;
  const InsertPostScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<InsertPostScreen> createState() => _InsertPostScreenState();
}

class _InsertPostScreenState extends State<InsertPostScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                TextForm(
                  label: 'Title of Post',
                  hint: 'Title...',
                  iconss: const Icon(Icons.email_outlined),
                  mycontroller: titleController,
                  isAlpha: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextForm(
                  label: 'Body',
                  hint: 'Body...',
                  iconss: const Icon(Icons.manage_accounts),
                  mycontroller: passController,
                  isAlpha: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if(formkey.currentState!.validate()){
                      PostModel post = PostModel.autoId(
                          userId: widget.id,
                          title: titleController.text,
                          body: passController.text);
                      objectBox.insertPostModel(post);
                      setState(() {

                      });
                      Navigator.pop(context);
                    }

                  },
                  child: Container(
                    height: 50,
                    width: 100,
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
                          'Create',
                          style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
