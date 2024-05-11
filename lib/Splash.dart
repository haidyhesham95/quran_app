import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_quran/Const/Styels.dart';
import 'package:my_quran/Screen/Home/Home_Page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home_Page(), // Make sure this is the correct class name
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/Splash.png'
            ),
            Text('القرآن الكريم',style:Styles.textStyle38)
          ],
        ),
      ),
    );
  }
}

