import 'package:bazaar_to_go/viewmodel/register_viewmodel.dart';
import 'package:bazaar_to_go/controllers/registration_controller.dart';
import 'package:bazaar_to_go/model/add_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => StateRegisterScreen();
}

class StateRegisterScreen extends State<RegisterScreen> {
  final Color kDarkBlueColor = const Color(0xFF363AC2);
  final _formKey = GlobalKey<FormBuilderState>();
  final RegistrationController controller = Get.put(RegistrationController());
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
          title: const Text("Seller Registration",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              FormBuilder(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  onChanged: () {
                    _formKey.currentState!.save();
                  },
                  skipDisabled: true,
                  child: Column(
                    children: [
                      const Text(
                        "Personal Details",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildtextfield(
                          name: "name",
                          label: "Full Name(as per PAN)",
                          hasError: controller.namehaserror),
                      SizedBox(
                        height: 20,
                      ),
                      FormBuilderDateTimePicker(
                        name: 'date_of_birth',
                        firstDate: DateTime(1970),
                        inputType: InputType.date,
                        format: DateFormat('yyyy-MM-dd'),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 243, 245, 245),
                          labelText: 'Date of Birth',
                          hintText: 'Date(YYYY/MM/DD)',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _formKey.currentState!.fields['date_range']
                                  ?.didChange(null);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        name: 'phone',
                        decoration: InputDecoration(
                          labelText: 'Phone No (WhatsApp)',
                          filled: true,
                          fillColor: Color.fromARGB(255, 243, 245, 245),
                          suffixIcon: controller.phonehaserror.value
                              ? const Icon(Icons.error, color: Colors.red)
                              : null,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.equalLength(10),
                        ]),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        name: 'pincode',
                        decoration: InputDecoration(
                          labelText: 'Pincode',
                          filled: true,
                          fillColor: Color.fromARGB(255, 243, 245, 245),
                          suffixIcon: controller.pinhaserror.value
                              ? const Icon(Icons.error, color: Colors.red)
                              : null,
                        ),
                        onChanged: (value) async {
                          List<PostOffice>? list =
                              await RegisterViewmodel.fetchPostOffices(
                                  value.toString());
                          if (list != null && list.isNotEmpty) {
                            _formKey.currentState?.patchValue({
                              'district': list[0].district,
                              'state': list[0].state,
                            });
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.equalLength(6),
                        ]),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildtextfield(
                          name: "city",
                          label: "Street/Locality",
                          hasError: controller.cityhaserror),
                      SizedBox(
                        height: 20,
                      ),
                      buildtextfield(
                          name: "district",
                          label: "District",
                          hasError: controller.cityhaserror),
                      SizedBox(
                        height: 20,
                      ),
                      buildtextfield(
                          name: "state",
                          label: "State",
                          hasError: controller.statehaserror),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Seller Account Details",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildtextfield(
                          name: "aadhar",
                          label: "Aadhar",
                          reqlength: 12,
                          hasError: controller.aadharhaserror),
                      SizedBox(
                        height: 20,
                      ),
                      buildtextfield(
                          name: "gstin",
                          label: "GSTIN",
                          reqlength: 15,
                          hasError: controller.gstinhaserror),
                      SizedBox(
                        height: 20,
                      ),
                      buildtextfield(
                          name: "pan",
                          label: "Pan Card Number",
                          reqlength: 10,
                          hasError: controller.panhaserror),
                      SizedBox(
                        height: 20,
                      ),
                      buildtextfield(
                          name: "bankaccount",
                          label: "Bank Account Number",
                          hasError: controller.accounthaserror),
                      SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Upload Documents",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            controller.updatePanLoading();
                            controller.panUrl =
                                (await controller.handleImageSelection())
                                    .toString();
                            controller.updatePanLoading();
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(240.w, 48.h),
                              backgroundColor: kDarkBlueColor),
                          child: Obx(
                            () => controller.panloading.value
                                ? SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    'Upload PAN',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            controller.updateSelfLoading();
                            controller.selfUrl =
                                (await controller.handleImageSelection())
                                    .toString();
                            controller.updateSelfLoading();
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(240.w, 48.h),
                              backgroundColor: kDarkBlueColor),
                          child: Obx(
                            () => controller.selfloading.value
                                ? SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    'Upload selfie',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FormBuilderCheckbox(
                          name: "terms",
                          title: Text("I accept terms and conditions")),
                      FormBuilderCheckbox(
                          name: "privacy",
                          title: Text("I accept privacy policy")),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.fields['terms']?.value ==
                                  true &&
                              _formKey.currentState!.fields['privacy']?.value ==
                                  true) {
                            // Create a new mutable map from the unmodifiable map
                            Map<String, dynamic> field =
                                Map.from(_formKey.currentState!.value);

                            // Now you can safely modify the new map
                            field.addAll({
                              "panUrl": controller.panUrl,
                              "selfUrl": controller.selfUrl,
                            });

                            print(field.toString());
                          } else {
                            Get.snackbar("Message","Kindly accept terms and conditions");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(240.w, 48.h),
                            backgroundColor: kDarkBlueColor),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildtextfield(
      {required String name,
      required String label,
      required Rx<bool> hasError,
      int? reqlength}) {
    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      name: name,
      decoration: InputDecoration(
        fillColor: Color.fromARGB(255, 243, 245, 245),
        filled: true,
        labelText: label,
        suffixIcon:
            hasError.value ? const Icon(Icons.error, color: Colors.red) : null,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        if (reqlength != null) FormBuilderValidators.equalLength(reqlength),
      ]),
      // initialValue: '12',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }
}
