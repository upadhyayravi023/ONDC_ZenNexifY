import 'package:bazaar_to_go/controllers/register_shop_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../../repository/api_service.dart';
import '../../repository/endpoint.dart';
import '../../widgets/bnb.dart'; // Import for JSON encoding

class RegisterShop extends StatefulWidget {
  final String username;
  const RegisterShop({super.key, required this.username});

  @override
  State<RegisterShop> createState() => _RegisterShopState();
}

class _RegisterShopState extends State<RegisterShop> {
  final _storeFormKey = GlobalKey<FormBuilderState>();
  final controller = Get.put(RegisterShopController());
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _storeStreetController = TextEditingController();
  final TextEditingController _storeCityController = TextEditingController();
  final TextEditingController _storeStateController = TextEditingController();
  final TextEditingController _storeZipController = TextEditingController();
  final TextEditingController _storeCountryController = TextEditingController();


  int _newTextFieldId = 0; // Initialize as an integer
  final Color kDarkBlueColor = const Color(0xFF363AC2);
  void _onregister() async {
    try {

      final response = await ApiService.post(
        Endpoint.postStore.getUrl(),
        {
        "storename": _storeNameController,
        "username": widget.username,
        "location": {
         "street": _storeStreetController,
        "city": _storeCityController,
      "state": _storeStateController,
      "zip": _storeZipController,
      "country": _storeCountryController
      },
        "contact": 1234567890
        }as Map<String, dynamic>,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Register Successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );


        Get.offAll(bnb(username: widget.username));
      } else {
        print("Register Failed: ${response.statusCode}, ${response.body}");
        Get.snackbar(
          'Error',
          'Register Failed: ${response.body}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      printError(info: error.toString());

      Get.snackbar(
        'Error',
        'Register failed. Please try again. \n$Error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlueColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset(
            "assets/images/cart_logo.png",
            colorBlendMode: BlendMode.colorDodge,
          ),
        ),
        title: const Text("Store Registration",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: _storeFormKey,
            clearValueOnUnregister: true,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                Obx(() => Column(
                  children: [
                    ...controller.fields,
                  ],
                )),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(240.w, 48.h),
                            backgroundColor: kDarkBlueColor),
                        onPressed: () {
                          final newTextFieldKey = ValueKey(_newTextFieldId);
                          controller.fields.add(LocalShop(
                            key: newTextFieldKey,
                            onDelete: () {
                              controller.fields.removeWhere((e) => e.key == newTextFieldKey);
                            },
                            index: _newTextFieldId, // Pass index for unique field names
                          ));
                          _newTextFieldId++; // Increment after adding
                        },
                        child: const Text("Local Store", style: TextStyle(
                            color: Colors.white, fontSize: 20)),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(240.w, 48.h),
                            backgroundColor: kDarkBlueColor),
                        onPressed: () {
                          final newTextFieldKey = ValueKey(_newTextFieldId);
                          controller.fields.add(OnlineShop(
                            key: newTextFieldKey,
                            onDelete: () {
                              controller.fields.removeWhere((e) => e.key == newTextFieldKey);
                            },
                            index: _newTextFieldId, // Pass index for unique field names
                          ));
                          _newTextFieldId++; // Increment after adding
                        },
                        child: const Text("Online Store", style: TextStyle(
                            color: Colors.white, fontSize: 20), textAlign: TextAlign.center,),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(240.w, 48.h),
                      backgroundColor: kDarkBlueColor),
                  onPressed: () {
                    if (_storeFormKey.currentState?.saveAndValidate() ?? false) {
                      // Convert to JSON
                      String jsonData = jsonEncode(_storeFormKey.currentState?.value);
                      print(jsonData);
                    } else {
                      print("Validation failed");
                    }
                  },
                  child: const Text("Submit", style: TextStyle(
                      color: Colors.white, fontSize: 20)),
                ),
                const Divider(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LocalShop extends StatelessWidget {
  const LocalShop({
    super.key,
    this.onDelete,
    required this.index,
  });
  final VoidCallback? onDelete;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Local Store", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          FormBuilderTextField(
            name: 'local_store_${index}_name',

            validator: FormBuilderValidators.required(),
            decoration: const InputDecoration(labelText: "Store Name"),
          ),
          FormBuilderTextField(
            name: 'local_store_${index}_gstin', // Unique field name
            validator: FormBuilderValidators.equalLength(15),
            decoration: const InputDecoration(labelText: "GSTIN"),
          ),
          SizedBox(height: 10),
          const Text("Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          FormBuilderTextField(
            name: 'local_store_${index}_pincode',

            // Unique field name
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
              FormBuilderValidators.equalLength(6),
            ]),
            decoration: const InputDecoration(labelText: "Pincode"),
          ),
          FormBuilderTextField(
            name: 'local_store_${index}_locality', // Unique field name
            validator: FormBuilderValidators.required(),
            decoration: const InputDecoration(labelText: "Locality/City"),
          ),
          FormBuilderTextField(
            name: 'local_store_${index}_district', // Unique field name
            validator: FormBuilderValidators.required(),
            decoration: const InputDecoration(labelText: "District"),
          ),
          FormBuilderTextField(
            name: 'local_store_${index}_state', // Unique field name
            validator: FormBuilderValidators.required(),
            decoration: const InputDecoration(labelText: "State"),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class OnlineShop extends StatelessWidget {

  const OnlineShop({
    super.key,
    this.onDelete,
    required this.index,
  });
  final VoidCallback? onDelete;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Online Store", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          FormBuilderTextField(
            name: 'online_store_${index}_shopify', // Unique field name
            initialValue: "Shopify",
            readOnly: true,
            decoration: const InputDecoration(labelText: "Shopify"),
          ),
          FormBuilderTextField(
            name: 'online_store_${index}_api_key', // Unique field name
            validator: FormBuilderValidators.required(),
            decoration: const InputDecoration(labelText: "API Key"),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}