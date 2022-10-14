import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {

  String title ;
  void Function()onPressed;


  AppTextButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
       title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
