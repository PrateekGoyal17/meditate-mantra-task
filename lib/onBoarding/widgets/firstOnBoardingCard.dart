import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FirstOnBoardingCard extends StatefulWidget {
  final String mainText;
  final String? secondText;
  final String? thirdText;
  final String? fourthText;
  final String imagePath;
  FirstOnBoardingCard(
      {super.key,
      required this.mainText,
      this.secondText,
      this.thirdText,
      this.fourthText,
      required this.imagePath,});

  @override
  State<FirstOnBoardingCard> createState() => _FirstOnBoardingCardState();
}

class _FirstOnBoardingCardState extends State<FirstOnBoardingCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.mainText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 55, fontFamily: "CoveredByYourGrace"),
            maxLines: 2,
          ),
          const SizedBox(
            height: 22,
          ),
          (widget.secondText == null && widget.thirdText == null && widget.fourthText == null)
              ? Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Image.asset(
                    widget.imagePath,
                  ),
                )
              : Image.asset(
                  widget.imagePath,
                  height: 255,
                  width: 255,
                ),
          widget.fourthText != null
              ?
              //fourthtext
              Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    widget.fourthText ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      fontFamily: "NunitoSans",
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : SizedBox(),
          widget.fourthText == null
              ?
              //secondtext
              Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    widget.secondText ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "NunitoSans",
                        fontSize: 32,
                        fontWeight: FontWeight.w600),
                  ),
                )
              : SizedBox(),
          widget.fourthText == null
              ?
              //thirdtext
              Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    widget.thirdText ?? "",
                    style: const TextStyle(
                        color: Color(0xffCC83E6),
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        fontFamily: "NunitoSans"),
                  ),
                )
              : SizedBox(),
          
        ],
      ),
    );
  }
}
