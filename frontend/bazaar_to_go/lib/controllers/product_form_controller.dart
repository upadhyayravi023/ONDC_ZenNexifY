import 'dart:convert';
import 'dart:io';

import 'package:bazaar_to_go/model/product.dart';
import 'package:bazaar_to_go/repository/cloudinary_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductFormController extends GetxController {
  var title = ''.obs;
  var price = ''.obs;
  var description = ''.obs;
  var attributes = <Map<String, String>>[].obs;
  RxList<String> images = <String>[].obs;
  var category = "".obs;
  var specifications = <Map<String, String>>[].obs;

  late Product product;
  void initializeFromJson(Product details) {
    print(details.toString());
    product = details;
    category.value = details.category;
    title.value = details.title;
    price.value = details.price.toString();
    description.value = details.description;
    images.value = details.images;
    attributes.clear();
    for (var attr in details.attributes) {
      attributes.add({'name': attr.name, 'value': attr.value});
    }
    // Initialize specifications
    specifications.clear();
    for (var spec in details.specifications) {
      specifications.add({'name': spec.name, 'value': spec.value});
    }
  }

  void addAttribute() {
    attributes.add({'name': '', 'value': ''});
  }

  void removeAttribute(int index) {
    attributes.removeAt(index);
  }

  void addSpecification() {
    specifications.add({'name': '', 'value': ''});
  }

  void removeSpecification(int index) {
    specifications.removeAt(index);
  }

  Map<String, dynamic> getFormData() {
    return product.toJson();
  }

  String toJson() {
    final Map<String, dynamic> jsonMap = {
      'title': title.value,
      'price': price.value,
      'description': description.value,
      'images': images.map((img) => img).toList(),
      'attributes': attributes.map((attr) => attr).toList(),
      'category': category.value,
      'specifications': specifications.map((spec) => spec).toList(),
    };

    return jsonEncode(jsonMap);
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
    return null;
  }
}
