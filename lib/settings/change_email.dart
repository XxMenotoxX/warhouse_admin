import 'package:admin_app_flutter/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:admin_app_flutter/utils/helpers.dart';
import 'package:admin_app_flutter/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> with Helpers {
  late TextEditingController _email;
  late User _user;

  @override
  void initState() {
    super.initState();
    _user  = FbAuthController().user;

    _email = TextEditingController(text: _user.email);
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // actions: [
        //   Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20),
        //       child: AppTextButton(
        //           title: 'Login',
        //           onPressed: () {
        //             Navigator.pushNamed(context, '/login_screen');
        //           })),
        // ],
        backgroundColor: Colors.transparent,
        // title: Text(
        //   'Login',
        //   style: TextStyle(
        //     fontWeight: FontWeight.w500,
        //     fontSize: 16,
        //     fontFamily: 'Montserrat',
        //   ),
        // ),
        leadingWidth: 80,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Color(0XFF252F41),
          //   image: DecorationImage(
          //       image: AssetImage('images/background.png'), fit: BoxFit.cover),
        ),
        child: Container(
          height: 450,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(40),
            ),
          ),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadiusDirectional.only(
          //     topEnd: Radius.circular(40),
          //   ),
          // ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              Text(
                'Change Email',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              AppTextField(
                hint: 'Enter new Email',
                controller: _email,
                textInputType: TextInputType.emailAddress,


              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 18,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          Color(0XFF273246),
                          Color(0XFF181D29),
                        ])),
                child: ElevatedButton(
                  onPressed: () async {
                    await performChangeEmail();
                  },
                  child: Text(
                    'change',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      primary: Colors.transparent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performChangeEmail() async {
    if (checkData()) {
      await changeEmail();
    }
  }

  bool checkData() {
    if (_email.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
        context: context, content: 'Enter required data!', error: true);
    return false;
  }

  Future<void> changeEmail() async {
    bool status =
        await FbAuthController().updateEmail(context, email: _email.text);
    if (status) {
      showSnackBar(
          context: context,
          content: 'Verification email sent, please check and confirm');
      FbAuthController().signOut();
      Navigator.pushReplacementNamed(context, '/login_screen');

    }
  }
}
