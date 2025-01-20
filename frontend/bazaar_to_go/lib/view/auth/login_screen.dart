import 'dart:convert';

import 'package:bazaar_to_go/controllers/login_controller.dart';
import 'package:bazaar_to_go/view/auth/register_screen.dart';
import 'package:bazaar_to_go/view/auth/signup_screen.dart';
import 'package:bazaar_to_go/view/splash_screen.dart';
import 'package:bazaar_to_go/widgets/bnb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../repository/api_service.dart';
import '../../repository/endpoint.dart';

class LoginScreen extends StatelessWidget {
  
  LoginScreen({super.key});
  void _onLogin() async {
    print(_usernameController.text);
    print(_passwordController.text);
    try {
      final response = await ApiService.post(
        Endpoint.login.getUrl(),
        {
          'username': _usernameController.text.toString(),
          'password': _passwordController.text.toString(),
        } as Map<String, dynamic>,
      );

      if (response.statusCode == 200) {

        final responseData = jsonDecode(response.body);

        Get.snackbar(
          'Success',
          'Login Successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll((bnb(username: _usernameController.text,)));
      } else {
        print("Login Failed: ${response.statusCode}, ${response.body}");
        Get.snackbar(
          'Error',
          'Login Failed: ${response.body}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      printError(info: error.toString());

      Get.snackbar(
        'Error',
        'Login failed. Please try again. \n$Error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Color kDarkBlueColor = const Color(0xFF363AC2);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Padding(
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
                      'Login',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25.h),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'username',
                          prefixIcon: const Icon(Icons.email),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkBlueColor))),
                      controller: _usernameController,
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      obscureText: !controller.showPassword.value,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon:  Obx(()=>IconButton(onPressed:()=>controller.togglePassword, icon: !controller.showPassword.value? const Icon(Icons.visibility): const Icon(Icons.visibility_off)),),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kDarkBlueColor))),
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Forgot Password ?'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                        _onLogin();
                      }
                      ,
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(240.w, 48.h),
                          backgroundColor: kDarkBlueColor),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account?"),
                        TextButton(
                          onPressed: () {
                            Get.off(SignupScreen());
                          },
                          child: const Text('Sign up'),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
