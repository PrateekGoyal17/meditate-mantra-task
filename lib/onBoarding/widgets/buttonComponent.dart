import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonComponent extends StatelessWidget {
  void Function() ontap;
  String buttonText;
  ButtonComponent({super.key, required this.ontap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(bottom:20.0),
        child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffCC83E6),
            ),
            child: Center(
                child: Text(
              buttonText,
              style: TextStyle(
                  color: Colors.black,fontFamily: "NunitoSans",  fontSize: 20,fontWeight: FontWeight.bold),
            ))),
      ),
    );
  }
}
