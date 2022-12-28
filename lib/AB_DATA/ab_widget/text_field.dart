import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String label;
  final String hint;
  final Icon iconss;
  final bool obsecure;
  final bool islogin;
  final bool ispassword;
  final bool isAlpha;
  final TextEditingController mycontroller;
  final TextInputType keyboard;
  const TextForm({Key? key,
  required this.label,
    required this.hint,
    required this.iconss,
    this.obsecure = false,
    required this.mycontroller,
    this.islogin = false,
    this.isAlpha = false,
    this.ispassword = false,
    this.keyboard = TextInputType.emailAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle:  TextStyle(
          color: Colors.grey.shade700,
          fontSize: 17,
        ),
        hintText: hint,
        hintStyle:  TextStyle(
          color: Colors.grey.shade700,
          fontSize: 17,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.grey,width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.grey,width: 2),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: iconss,
      ),
      obscureText: false,
      keyboardType: keyboard,
      validator: (String? value){
        if(value == null || value.isEmpty){
          return 'Please Enter Some Text';
        }
        else if(islogin){
          if(!value.contains('@gmail')){
            return 'Username should contain @gmail';
          }
        }
        else if(isAlpha){

          if(!value.contains(RegExp(r'^[a-zA-Z0-9 ]+$'))){
            return 'Enter Some Alphabets ';
          }
        }
        else if(ispassword){
          RegExp regex =
          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
          if(value.isEmpty){
            return 'Enter Your Password';
          }
          else if(value.length <= 8){
            return 'Password Must be more than 8 chracters';
          }
          else if(!regex.hasMatch(value)){
            return 'Password should contain upper,lower,digit and Special character ';
          }
        }
        return null;
      },
      controller: mycontroller,

    );
  }
}
