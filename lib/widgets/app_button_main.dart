import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:flutter/material.dart';

class AppButtonMain extends StatelessWidget {
  void Function() onPressed;
  String title;

  AppButtonMain({required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: AlignmentDirectional.centerStart,
              end: AlignmentDirectional.centerEnd,
              colors: [
                Color(0XFF273246),
                Color(0XFF181D29),
              ])),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: SizeConfig().scaleTextFont(16),
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, SizeConfig().scaleHeight(50)),
            primary: Colors.transparent),
      ),
    );
  }
}
