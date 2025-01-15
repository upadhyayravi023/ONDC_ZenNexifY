import 'package:get/get.dart';

class SignupController extends GetxController{
    RxBool showPassword = false.obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }
}