import 'package:bazaar_to_go/view/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _ondcAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define animations
    _logoAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    );

    _ondcAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animations
    _animationController.forward();

    // Navigate to the OnBoarding screen after a delay
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.off(
        const OnBoarding(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          ScaleTransition(
            scale: _logoAnimation,
            child: Image.asset("assets/images/logo.png"),
          ),
          const Spacer(),
          FadeTransition(
            opacity: _ondcAnimation,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50.h),
              child: Center(child: Image.asset("assets/images/ondc.png")),
            ),
          ),
        ],
      ),
    );
  }
}
