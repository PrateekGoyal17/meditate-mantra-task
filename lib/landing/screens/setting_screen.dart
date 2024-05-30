import 'package:flutter/material.dart';
import 'package:meditate_mantra_task/auth/services/firebaseService.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        toolbarHeight: 103,
        backgroundColor: Colors.white,
        title: Text(
          "Your Profile",
          style: TextStyle(
              fontFamily: "NunitioSans",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 36.0, bottom: 16),
                child: Icon(
                  Icons.contacts_rounded,
                  size: 60,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "User Name ",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.edit)
                  ],
                ),
              ),
              Text("username@gmail.com")
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Feedback",
              style:
                  TextStyle(color: Color(0xffAdaaaa), fontFamily: "NunitoSans"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Rate Meditate Mantra 5 stars",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Share app with your friends",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Others",
              style:
                  TextStyle(color: Color(0xffAdaaaa), fontFamily: "NunitoSans"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Privacy Policy",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Delete account",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "NunitoSans",
                  fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              FirebaseService(context).logout();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Log out",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "NunitoSans",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: Center(
              child: Text(
                "Version 1.0",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
              ),
            ),
          )
        ],
      ),
    );
  }
}
