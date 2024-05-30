import 'package:flutter/material.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 150.0,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16, bottom: 50),
            child: Text(
              "Forgot Password",
              style: TextStyle(
                  color: Color(
                    0xffCC83E6,
                  ),
                  fontFamily: "CoveredByYourGrace",
                  fontSize: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Password reset link has been sent to your email address.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          )
        ]),
      ),
    );
  }
}
