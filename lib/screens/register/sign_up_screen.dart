import 'package:admin_app_flutter/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:admin_app_flutter/firebase/firestore/fb_store_controller.dart';
import 'package:admin_app_flutter/model/user_model.dart';
import 'package:admin_app_flutter/utils/helpers.dart';
import 'package:admin_app_flutter/widgets/app_button_main.dart';
import 'package:admin_app_flutter/widgets/app_text_button.dart';
import 'package:admin_app_flutter/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Helpers {
  late TextEditingController _username;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _confirmPassword;
  bool _value = false;
 late  User _user;

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();

  }

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppTextButton(
                  title: 'Login',
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_screen');
                  })),
        ],
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
          color: Color(0XFFFDBC02),
          // image: DecorationImage(
          //     image: AssetImage('images/background.png'), fit: BoxFit.cover),
        ),
        child: Container(
          height: 550,
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
              Align(
                alignment: AlignmentDirectional.topStart,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Signup',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              AppTextField(hint: 'UsernName', controller: _username),
              SizedBox(
                height: 10,
              ),
              AppTextField(hint: 'Email', controller: _email,textInputType: TextInputType.emailAddress,),
              SizedBox(
                height: 10,
              ),
              AppTextField(hint: 'Password', controller: _password,obscure: true),
              SizedBox(
                height: 10,
              ),
              AppTextField(
                  hint: 'Confirm Password', controller: _confirmPassword,obscure: true,),
              SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Color(0XFFFFDBC02),
                  title: RichText(
                    text: TextSpan(
                        text: 'I read & agree with',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                        ),
                        children: [
                          TextSpan(text: ' '),
                          TextSpan(
                              text: 'terms & policy',
                              style: TextStyle(
                                color: Color(0XFFFDBC02),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                              ))
                        ]),
                  ),
                  value: _value,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        _value = value;
                      }
                    });
                  }),
              SizedBox(
                height: 18,
              ),
              AppButtonMain(
                  onPressed: () async {
                    await performCreateAccount();

                  },
                  title: 'Signup now')
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performCreateAccount() async {
    if (checkData()) {
      await createAccount();
    }

  }

  bool checkData() {
    if (_email.text.isNotEmpty &&
        _password.text.isNotEmpty &&
        _confirmPassword.text.isNotEmpty &&
        _username.text.isNotEmpty) {
      if (_password.text == _confirmPassword.text) {
        return true;
      }
      showSnackBar(
          context: context,
          content: 'password is not equal to confirm password',
          error: true);
    }
    showSnackBar(
        context: context,
        content: 'Enter email & password &username',
        error: true);
    return false;
  }

  Future<void> createAccount() async {
    bool status = await FbAuthController()
        .createAccount(context, email: _email.text, password: _password.text);
    if(status){
      Navigator.pushNamed(context,'/login_screen');

    }
    }



}
