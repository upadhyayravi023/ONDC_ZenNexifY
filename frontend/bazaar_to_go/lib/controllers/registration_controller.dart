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
  RxString name = ''.obs;
  RxString dob = ''.obs;
  RxString phone = ''.obs;

  // Address
  RxString pincode = ''.obs;
  RxString street = ''.obs;
  RxString district = ''.obs;
  RxString state = ''.obs;

  // Account details
  RxString aadhar = ''.obs;
  RxString pan = ''.obs;
  RxString gstin = ''.obs;
  RxString bankAccount = ''.obs;

  void updateField(String field, String value) {
    switch (field) {
      case 'name':
        name.value = value;
        break;
      case 'dob':
        dob.value = value;
        break;
      case 'phone':
        phone.value = value;
        break;
      case 'pincode':
        pincode.value = value;
        break;
      case 'street':
        street.value = value;
        break;
      case 'district':
        district.value = value;
        break;
      case 'state':
        state.value = value;
        break;
      case 'aadhar':
        aadhar.value = value;
        break;
      case 'pan':
        pan.value = value;
        break;
      case 'gstin':
        gstin.value = value;
        break;
      case 'bankAccount':
        bankAccount.value = value;
        break;
    }
  }

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

