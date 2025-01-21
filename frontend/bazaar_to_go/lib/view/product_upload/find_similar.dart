import 'package:bazaar_to_go/controllers/upload_product_controller.dart';
import 'package:bazaar_to_go/model/amazon_product.dart';
import 'package:bazaar_to_go/view/product_upload/product_form_page.dart';
import 'package:bazaar_to_go/viewmodel/amazon_products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindSimilar extends StatefulWidget {
  const FindSimilar({super.key});

  @override
  State<FindSimilar> createState() => StateFindSimilar();
}

class StateFindSimilar extends State<FindSimilar> {
  final Color kDarkBlueColor = const Color(0xFF363AC2);
  final TextEditingController textcontroller = TextEditingController();
  final controller = Get.put(UploadProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                    controller: textcontroller,
                    decoration: InputDecoration(
                        labelText: 'Write product to upload',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 243, 245, 245),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              controller.changeLoading();
                              controller.products.value =
                                  await AmazonProductViewModel
                                          .getsimilarProducts(
                                              textcontroller.text) ??
                                      [];
                              controller.changeLoading();
                            },
                            icon: const Icon(Icons.search)))),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 600,
                child: Obx(
                  () => controller.products.isEmpty
                      ? (controller.isLoading.value
                          ? Center(
                              child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator()),
                            )
                          : Center(
                              child: Text("Search the similar product"),
                            ))
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return buildProductCard(controller.products[index]);
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductCard(AmazonProduct product) {
    return GestureDetector(
      onTap: () async {
        final details =
            await AmazonProductViewModel.getProductDetails(product.asin);
        if (details != null) {
          Get.to(ProductFormPage(initialInstance: details));
        }
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                product.thumbnail,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                '${product.title}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                product.price,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Product ID: ${product.asin}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
