import 'package:flutter/material.dart';
import 'package:meditate_mantra_task/auth/screens/signup_screen.dart';
import 'package:meditate_mantra_task/onBoarding/widgets/buttonComponent.dart';
import 'package:meditate_mantra_task/onBoarding/widgets/firstOnBoardingCard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      FirstOnBoardingCard(
        mainText: "Guided Meditations",
        secondText: "For beginners",
        thirdText: "for free!",
        imagePath: "assets/images/first.png",
      ),
      FirstOnBoardingCard(
        mainText: "Build a healthy habit",
        fourthText: "Don't you worry because all it takes is 21 days :)",
        imagePath: "assets/images/second.png",
      ),
      FirstOnBoardingCard(
        mainText: "All in one",
        imagePath: "assets/images/third.png",
      ),
      FirstOnBoardingCard(
        mainText: "Mindful Activity",
        fourthText:
            "Receive daily self-care tips and mini mindful activities to uplift your afternoon",
        imagePath: "assets/images/fourth.png",
      ),
    ];

    void onButtonTap() {
      currentIndex++;
      setState(() {});
      pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    }

    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {});
                currentIndex = value;
              },
              controller: pageController,
              itemCount: 4,
              itemBuilder: ((context, index) {
                return pages[index];
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SmoothPageIndicator(
              controller: pageController,
              count: 4,
              effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Color(0xffCC83E6),
                  dotColor: Color.fromARGB(255, 191, 195, 203)),
            ),
          ),
          (currentIndex == 0 || currentIndex == 1)
              ? ButtonComponent(
                  buttonText: "Awesome!",
                  ontap: onButtonTap,
                )
              : (currentIndex == 2)
                  ? ButtonComponent(ontap: onButtonTap, buttonText: "Wooahh!")
                  : ButtonComponent(
                      ontap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()),
                            (Route route) => false);
                      },
                      buttonText: "That's exciting")
        ]),
      ),
    );
  }
}
