import 'package:bazaar_to_go/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoarding extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF363AC2);

  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnBoardingSlider(
        finishButtonText: 'Get Started',
        onFinish: () {
          Get.to( LoginScreen());
        },
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: kDarkBlueColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.r))),
        ),
        trailing: Text(
          "Login",
          style: TextStyle(
            fontSize: 16,
            color: kDarkBlueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailingFunction: () {
          Get.to( LoginScreen());
        },
        skipTextButton: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            color: kDarkBlueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        controllerColor: kDarkBlueColor,
        totalPage: 3,
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        background: [
          Image.asset(
            'assets/images/slide_1.png',
            height: 400,
            width: 300.w,
          ),
          Image.asset(
            'assets/images/slide_2.png',
            height: 400,
            width: 300.w,
          ),
          Image.asset(
            'assets/images/slide_3.png',
            height: 400,
            width: 300.w,
          ),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            alignment: Alignment.center,
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text(
                  'Welcome to your \n Virtual Market',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDarkBlueColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Transform Your Local Shop in a thriving online business!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text(
                  'Streamline \n Order Management',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDarkBlueColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Easily manage orders and inventory from one intututive platform',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text(
                  'AI Powered \n Product Description Writer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDarkBlueColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Leverage power of our AI for writing fast and quick product description ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
