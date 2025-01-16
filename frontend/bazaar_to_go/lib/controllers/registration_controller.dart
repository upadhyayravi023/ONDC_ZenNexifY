import 'dart:io';

import 'package:bazaar_to_go/repository/cloudinary_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  Rx<bool> namehaserror = false.obs;
  Rx<bool> phonehaserror = false.obs;
  Rx<bool> statehaserror = false.obs;
  Rx<bool> cityhaserror = false.obs;
  Rx<bool> pinhaserror = false.obs;
  Rx<bool> aadharhaserror = false.obs;
  Rx<bool> panhaserror = false.obs;
  Rx<bool> accounthaserror = false.obs;
  Rx<bool> gstinhaserror = false.obs;
  Rx<bool> panloading = false.obs;
  Rx<bool> selfloading = false.obs;
  String panUrl = "";
  String selfUrl = "";

  Future<String?> handleImageSelection() async {
    final XFile? imagePicked =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (imagePicked != null) {
      final file = File(imagePicked.path);
      try {
        final uri = await CloudinaryService.uploadFile(file);
        if (uri.toString() != 'https://example.com') {
          return uri.toString();
        } else {
          Get.snackbar("Error", "Failed to upload image ${imagePicked.name}");
        }
        return null;
      } catch (e) {
        return null;
      }
    }
  }

  void updatePanLoading() {
    panloading.value = !panloading.value;
  }

  void updateSelfLoading() {
    selfloading.value = !selfloading.value;
  }
}
