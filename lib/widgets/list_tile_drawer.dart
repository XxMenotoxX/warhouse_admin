import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {

  IconData iconData;
  String title;
  void Function()onTab;


  DrawerListTile({required this.iconData,required  this.title,required  this.onTab});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTab,
      leading: Icon(
        iconData,
        color: Color(0XFFFDBC02),
      ),
      title: Text(
       title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.white,
          fontFamily: 'Montserrat',

        ),
      ),
    );
  }
}
