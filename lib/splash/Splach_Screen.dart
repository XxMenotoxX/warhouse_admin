import 'dart:ui';

import 'package:admin_app_flutter/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Splachscreen extends StatefulWidget {


  @override
  _SplachscreenState createState() => _SplachscreenState();
}

class _SplachscreenState extends State<Splachscreen> {
  void initState() {

    super.initState();
    // don't delete this line ///

    String route = FbAuthController().isLoggedIn?'/main_categories':'/login_screen';
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, route);

    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().designWidth(3.75).designHeight(8.13).init(context);

    return Scaffold(

backgroundColor: Color(0XFF242E40),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: AlignmentDirectional.topEnd,
                end: AlignmentDirectional.bottomStart,
                colors: [
                  Color(0XFF273246),
                  Color(0XFF181D29),
                  Color(0XFF242E41),


                ])),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            SizedBox(height:SizeConfig().scaleHeight(250) ,width:SizeConfig().scaleWidth(300),
              child:Lottie.asset('assets/24679-order-box-animation.json'),),

            // Text('Drinks App',style: TextStyle(
            //   fontFamily: 'Montserrat',
            //     fontWeight: FontWeight.w700,
            //     color: Colors.deepOrange,fontSize: SizeConfig().scaleTextFont(40)),)
          ],
        ),
      ),
    );
  }
}
