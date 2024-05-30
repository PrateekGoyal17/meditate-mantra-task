import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditate_mantra_task/auth/screens/forgotpass_screen.dart';
import 'package:meditate_mantra_task/auth/screens/signup_screen.dart';
import 'package:meditate_mantra_task/auth/services/firebaseService.dart';
import 'package:meditate_mantra_task/auth/services/validation.dart';
import 'package:meditate_mantra_task/music/screens/loading_screen.dart';
import 'package:meditate_mantra_task/onBoarding/widgets/blackButton.dart';
import 'package:meditate_mantra_task/onBoarding/widgets/buttonComponent.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isEmailinValid = false;

  bool isPasswordinValid = false;
  bool isPasswordIncorrect = false;

  void logIn() async {
    FirebaseService firebaseService = FirebaseService(context);
    isEmailinValid = Validator.validateEmail(email: emailController.text);

    isPasswordinValid =
        Validator.validatePassword(password: passwordController.text);

    if (!isEmailinValid && !isPasswordinValid) {
      String validateLogin = await firebaseService.logIn(
          emailController.text, passwordController.text);
      if (validateLogin == "No user found for that email.") {
        isEmailinValid = true;
      } else if (validateLogin == "invalid-credential") {
        isPasswordIncorrect = true;
      } else {
        isEmailinValid = true;
        isPasswordIncorrect = true;
      }
    }

    setState(() {});
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
                "Log In",
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
                buttonText: "Log in with Google"),
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
                  isPasswordIncorrect
                      ? Container(
                          height: 40,
                          child: Text(
                            "Invalid Password",
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : isPasswordinValid
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
                  ButtonComponent(ontap: logIn, buttonText: "Log In"),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Forgot Password"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen()));
                            },
                            child: Text(
                              "Click Here!",
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
                    ],
                  ),
                  Row(
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
                                  builder: ((context) => SignupScreen())));
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
