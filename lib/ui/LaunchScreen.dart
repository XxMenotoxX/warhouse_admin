import 'package:flutter/material.dart';
class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(context, '/sub_category_screen');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
            body: Center(
            child:Text(
              'Drinks App',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                fontSize: 26,
                color: Colors.black,
                wordSpacing: 10,
                letterSpacing: 5,
                decorationThickness: 3,
                decorationColor: Colors.pink,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
         ),
    );
  }
}
