import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditate_mantra_task/auth/screens/login_screen.dart';
import 'package:meditate_mantra_task/auth/services/firebaseService.dart';
import 'package:meditate_mantra_task/auth/services/validation.dart';
import 'package:meditate_mantra_task/music/screens/loading_screen.dart';
import 'package:meditate_mantra_task/onBoarding/widgets/blackButton.dart';
import 'package:meditate_mantra_task/onBoarding/widgets/buttonComponent.dart';

// ignore: must_be_immutable
class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isEmailinValid = false;

  bool isPasswordinValid = false;

  void signUp() async {
    setState(() {});
    FirebaseService firebaseService = FirebaseService(context);

    isEmailinValid = Validator.validateEmail(email: emailController.text);

    isPasswordinValid =
        Validator.validatePassword(password: passwordController.text);

    if (!isEmailinValid && !isPasswordinValid) {
      await firebaseService.signUp(
          emailController.text, passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 67),
              child: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                  height: 122,
                  width: 131,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16),
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Color(
                      0xffCC83E6,
                    ),
                    fontFamily: "CoveredByYourGrace",
                    fontSize: 40),
              ),
            ),
            // Google sign in
            BlackButton(
                ontap: () async {
                  User? user = await FirebaseService.signInWithGoogle();
                  print(user);
                  print("*******");
                  if (user != null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoadingScreen()),
                        (Route route) => false);
                  }
                },
                buttonText: "Sign up with Google"),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    // width: MediaQuery.of(context).size.width * 0.44,
                    height: 0.8,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("or"),
                ),
                Expanded(
                  child: Container(
                    // width: MediaQuery.of(context).size.width * 0.44,
                    height: 0.8,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email-ID",
                    style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, right: 16),
                    child: SizedBox(
                      height: 54,
                      child: TextField(
                        controller: emailController,
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
                  isEmailinValid
                      ? Container(
                          height: 40,
                          child: Text(
                            'Email ID entered is incorrect.',
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : Container(
                          height: 40,
                        ),
                  const Text(
                    "Password",
                    style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, right: 16),
                    child: SizedBox(
                      height: 54,
                      child: TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  isPasswordinValid
                      ? Container(
                          height: 40,
                          child: Text(
                            "Password length must be more than 5!",
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : Container(
                          height: 40,
                        ),
                  ButtonComponent(ontap: signUp, buttonText: "Sign Up"),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already a member?",
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
                            builder: ((context) => LoginScreen())));
                  },
                  child: Text("Log in",style: TextStyle(color: Color(0xffCC83E6),),),
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(TextStyle(
                          
                          fontFamily: "NunitoSans",
                          fontSize: 16,
                          fontWeight: FontWeight.bold))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
