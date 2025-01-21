import 'package:bazaar_to_go/model/product.dart';
import 'package:bazaar_to_go/view/product_upload/find_similar.dart';
import 'package:bazaar_to_go/view/product_upload/product_form_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/upload_product_controller.dart';

class UploadProductScreen extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF363AC2);
  final controller = Get.put(UploadProductController());

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
            SizedBox(height: 20),
           ElevatedButton(
                      onPressed: (){
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kDarkBlueColor),
                      child: const Text(
                        'Upload Manually',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
            SizedBox(height: 20),
           ElevatedButton(
                      onPressed: (){
                        Get.to(FindSimilar());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kDarkBlueColor),
                      child: const Text(
                        'Product from Platfrom',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
            SizedBox(height: 20),
            ElevatedButton(
                      onPressed: (){
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kDarkBlueColor),
                      child: const Text(
                        'Upload using AI',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
            SizedBox(height: 20),
            Text("Use our Template",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            SizedBox(
              height: 350,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                ),
                itemCount: controller.templates.length,
                itemBuilder: (context, index) {
                  return buildTemplateCard(controller.templates[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTemplateCard(Product product) {
    return GestureDetector(
      onTap: () async {
        Get.to(ProductFormPage(initialInstance: product));
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.images[0],
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                product.category,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
