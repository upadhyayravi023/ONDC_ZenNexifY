import 'package:bazaar_to_go/controllers/product_form_controller.dart';
import 'package:bazaar_to_go/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class ProductFormPage extends StatelessWidget {
  final ProductFormController controller = Get.put(ProductFormController());
  final GlobalKey<FormBuilderState> _productFormKey =
      GlobalKey<FormBuilderState>();
  final Product initialInstance;

  ProductFormPage({super.key, required this.initialInstance}) {
    controller.initializeFromJson(initialInstance);
  }
  final Color kDarkBlueColor = const Color(0xFF363AC2);

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
        title: const Text("Product Upload",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Obx(
                () {
                  final images = controller.images;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  controller.images.removeAt(index);
                                },
                                icon: Icon(Icons.delete),
                              )),
                          Image.network(
                            images[index],
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final link = await controller.handleImageSelection();
                  if (link != null) {
                    controller.images.add(link);
                  }
                },
                child: Text('Upload Images')),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 30, top: 20),
              child: FormBuilder(
                key: _productFormKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'title',
                      decoration: InputDecoration(labelText: 'Title'),
                      initialValue: controller.title.value,
                      onChanged: (value) =>
                          controller.title.value = value ?? '',
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderTextField(
                      name: 'price',
                      decoration: InputDecoration(labelText: 'Price'),
                      initialValue: controller.price.value,
                      onChanged: (value) =>
                          controller.price.value = value ?? '',
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderTextField(
                      name: 'description',
                      decoration: InputDecoration(labelText: 'Description'),
                      initialValue: controller.description.value,
                      onChanged: (value) =>
                          controller.description.value = value ?? '',
                      validator: FormBuilderValidators.required(),
                    ),
                    FormBuilderTextField(
                      name: 'category',
                      decoration: InputDecoration(labelText: 'Category'),
                      initialValue: controller.category.value,
                      onChanged: (value) =>
                          controller.category.value = value ?? '',
                      validator: FormBuilderValidators.required(),
                    ),
                    SizedBox(height: 20),
                    Text('Attributes'),
                    Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.attributes.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: FormBuilderTextField(
                                  name: 'attribute_name_$index',
                                  decoration: InputDecoration(
                                      labelText: controller.attributes[index]
                                          ['name']),
                                  initialValue: controller.attributes[index]
                                      ['value'],
                                  onChanged: (value) {
                                    controller.attributes[index]['name'] =
                                        value ??
                                            controller.attributes[index]['name']
                                                .toString();
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () =>
                                    controller.removeAttribute(index),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                    SizedBox(height: 20),
                    const Text('Specifications'),
                    Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.specifications.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: FormBuilderTextField(
                                  name: 'specification_name_$index',
                                  decoration: InputDecoration(
                                      labelText: controller
                                          .specifications[index]['name']),
                                  initialValue: controller.specifications[index]
                                      ['value'],
                                  onChanged: (value) {
                                    controller.specifications[index]['value'] =
                                        value ??
                                            controller.specifications[index]
                                                    ['value']
                                                .toString();
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () =>
                                    controller.removeSpecification(index),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_productFormKey.currentState?.saveAndValidate() ??
                            false) {
                          print(controller.toJson());
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
