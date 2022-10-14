import 'package:admin_app_flutter/model/main_categories.dart';
import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:admin_app_flutter/screens/register/forget_password_screen.dart';
import 'package:admin_app_flutter/screens/register/login_screen.dart';
import 'package:admin_app_flutter/screens/register/sign_up_screen.dart';
import 'package:admin_app_flutter/settings/ProfileSetting.dart';
import 'package:admin_app_flutter/settings/change_email.dart';
import 'package:admin_app_flutter/settings/change_password.dart';
import 'package:admin_app_flutter/settings/change_profile.dart';
import 'package:admin_app_flutter/splash/Splach_Screen.dart';
import 'package:admin_app_flutter/ui/LaunchScreen.dart';
import 'package:admin_app_flutter/control_panel/add_category_screen.dart';
import 'package:admin_app_flutter/ui/categories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      initialRoute: '/splash_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/forget_password_screen': (context) => ForgetPassword(),
        '/sign_up_screen': (context) => SignUpScreen(),
        '/add_category_screen': (context) => AddCategoryScreen(),
        '/main_categories': (context) => Categories(),
        '/splash_screen': (context) => Splachscreen(),
        '/profile_settings': (context) => ProfileSetting(),
        '/change_password': (context) => ChangePassword(),
        '/change_Email': (context) => ChangeEmail(),
        '/change_profile': (context) => ChangeProfile(),
      },
    );
  }
}
