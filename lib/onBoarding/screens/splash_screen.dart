import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meditate_mantra_task/onBoarding/screens/onBoarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnBoarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/logo.png",
                fit: BoxFit.contain),
          ),
          // Center(child: SvgPicture.asset("assets/images/logo.svg")),
        ],
      ),
    );
  }
}
