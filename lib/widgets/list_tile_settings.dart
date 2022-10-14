import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:flutter/material.dart';

class ListTileSettings extends StatelessWidget {
  late String title;

  late String subTitle;
  late IconData leadingIconData;
  late void Function() onPressed;

  ListTileSettings(
      {required this.title,
      required this.subTitle,
      required this.onPressed,
      required this.leadingIconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: Offset(0, 3),
              blurRadius: 12,
              spreadRadius: 2,
            )
          ]),
      child: ListTile(
        onTap: onPressed,
        leading: Container(
          height: SizeConfig().scaleHeight(36),
          width: SizeConfig().scaleWidth(36),
          decoration: BoxDecoration(
            color: Color(0XFFE1E4EB).withOpacity(0.6),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(
            leadingIconData,
            color: Color(0XFFFDBC02),
            size: SizeConfig().scaleHeight(25),
          ),
        ),
        title: Text(title,
            style: TextStyle(
              color: Color(0XFF303030),
              fontFamily: 'Montserrat',
              fontSize: SizeConfig().scaleTextFont(16),
              fontWeight: FontWeight.w700,
            )),
        subtitle: Text(
          subTitle,
          style: TextStyle(
              color: Colors.grey.shade400,
              fontFamily: 'Montserrat',
              fontSize: SizeConfig().scaleTextFont(14),
              fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Color(0XFFFDBC02),
        ),
      ),
    );
  }
}
