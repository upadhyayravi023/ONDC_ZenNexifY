import 'package:bazaar_to_go/view/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.off(
        const OnBoarding(),
        transition: Transition
            .rightToLeft, // Or Transition.fadeIn, Transition.rightToLeft, etc.
        duration: const Duration(
            milliseconds: 500), // Adjust the duration for smoothness
        curve: Curves.easeInOut, // Choose a curve for the animation
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          Image.asset("assets/images/logo.png"),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: Center(child: Image.asset("assets/images/ondc.png")),
          )
        ],
      ),
    );
  }
}
