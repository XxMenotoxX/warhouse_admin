import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  late String hint;
  late TextEditingController controller;
  late TextInputType textInputType  = TextInputType.text;
  late bool obscure= false;

  AppTextField(
      {required this.hint,
      required this.controller,
      this.obscure = false,
      this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      obscureText: obscure,
      controller: controller,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Montserrat',
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0XFFF303030).withOpacity(.50),
            fontSize: 16,
            fontWeight: FontWeight.w500),
        fillColor: Color(0XFFF3F3F3),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0XFFF3F3F3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0XFFFFDBC02), width: 2),
        ),
      ),
    );
  }
}
