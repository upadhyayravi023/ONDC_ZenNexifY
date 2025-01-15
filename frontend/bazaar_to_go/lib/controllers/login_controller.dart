import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool showPassword = false.obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }
}
