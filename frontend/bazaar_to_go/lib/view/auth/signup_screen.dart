import 'dart:convert';

import 'package:bazaar_to_go/controllers/signup_controller.dart';
import 'package:bazaar_to_go/repository/api_service.dart';
import 'package:bazaar_to_go/repository/endpoint.dart';
import 'package:bazaar_to_go/view/auth/login_screen.dart';
import 'package:bazaar_to_go/view/auth/register_screen.dart';
import 'package:bazaar_to_go/view/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class SignupScreen extends StatelessWidget {
  void _onSignup() async {
    print(_username.text);
    print(_emailController.text);
    print(_passwordController.text);
    try {
      final response = await ApiService.post(
        Endpoint.signUp.getUrl(),
        {
          'username': _username.text.toString(),
          'email': _emailController.text.toString(),
          'password': _passwordController.text.toString()
        }as Map<String, dynamic>,
      );
print("1");
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Signup Successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );


        Get.offAll(RegisterScreen(username: _username.text));
      } else {
        print("Signup Failed: ${response.statusCode}, ${response.body}");
        Get.snackbar(
          'Error',
          'Signup Failed: ${response.body}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      printError(info: error.toString());

      Get.snackbar(
        'Error',
        'Signup failed. Please try again. \n$Error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  SignupScreen({super.key});
  final Color kDarkBlueColor = const Color(0xFF363AC2);
   final TextEditingController _username = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 360.h,
                        width: 320.w,
                        child: Image.asset(
                          'assets/images/login_image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25.h),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon:
                                const Icon(CupertinoIcons.person_alt_circle),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kDarkBlueColor))
                        ),
                        controller: _username,
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kDarkBlueColor))),
                        controller: _emailController,
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: Obx(
                              () => IconButton(
                                  onPressed: () => controller.togglePassword,
                                  icon: !controller.showPassword.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kDarkBlueColor))),
                        controller: _passwordController,
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          _onSignup();
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(240.w, 48.h),
                            backgroundColor: kDarkBlueColor),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have account?"),
                          TextButton(
                            onPressed: () {
                              Get.off(LoginScreen());
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
