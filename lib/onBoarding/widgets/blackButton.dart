import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlackButton extends StatelessWidget {
  void Function() ontap;
  String buttonText;
  BlackButton({super.key, required this.ontap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/google-logo.png"),
              SizedBox(
                width: 5,
              ),
              Text(
                buttonText,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          
        ),
      ),
    );
  }
}
