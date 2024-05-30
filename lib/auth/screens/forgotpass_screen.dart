import 'package:flutter/material.dart';
import 'package:meditate_mantra_task/auth/services/firebaseService.dart';
import 'package:meditate_mantra_task/music/screens/loading_screen.dart';
import 'package:meditate_mantra_task/onBoarding/widgets/buttonComponent.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController forgotPassController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 150.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                    ),
                    child: Text(
                      "Email-ID",
                      style: TextStyle(
                          fontFamily: "NunitoSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, right: 16, left: 16),
                    child: SizedBox(
                      height: 54,
                      child: TextField(
                        controller: forgotPassController,
                        decoration: const InputDecoration(
                          hintText: "Enter your email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 80.0,
                  left: 16,
                ),
                child: ButtonComponent(ontap: () {
                  FirebaseService(context).forgotPassword(forgotPassController.text);
                }, buttonText: "Log In"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not a member?",
                      style: TextStyle(
                          fontFamily: "NunitoSans",
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => LoadingScreen())));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xffCC83E6),
                        ),
                      ),
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(TextStyle(
                              fontFamily: "NunitoSans",
                              fontSize: 16,
                              fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
