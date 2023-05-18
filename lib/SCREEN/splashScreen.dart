import 'dart:async';

import 'package:employees_book/SHAREDPREFERENCE/sharedPreffenceData.dart';
import 'package:employees_book/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashTimer();
  }

  void splashTimer() async {
    Timer(
      const Duration(seconds: 5),
      () async {
        if (await getVsitingFlag() == true) {
          Navigator.pushNamed(context, '/homeScreen');
        } else {
          await Navigator.pushNamed(context, '/loginScreen');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: SizedBox(
          width: widgetSize.width / 2,
          child: Image.asset("assets/images/splash_logo.png"),
        ),
      ),
    );
  }
}
