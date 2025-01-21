import 'dart:convert';
import 'package:bazaar_to_go/model/amazon_product.dart';
import 'package:bazaar_to_go/model/product.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AmazonProductViewModel {
  static Future<List<AmazonProduct>?> getsimilarProducts(String query) async {
    final queryparameter = query.replaceAll(' ', '%20');
    final uri = Uri.parse(
        'https://www.searchapi.io/api/v1/search?api_key=g1frYMnX55eSXczx2qY5S6UF&amazon_domain=amazon.in&engine=amazon_search&q=$queryparameter&page=20');
    if (query.isNotEmpty) {
      try {
        final http.Response response = await http.get(uri);

        if (response.statusCode == 200) {
          try {
            final decodedJson = jsonDecode(response.body);
            print((decodedJson['organic_results'])
                .toString()); // Print the entire JSON response for debugging

            if (decodedJson.containsKey('organic_results')) {
              final List<dynamic> organicResults =
                  decodedJson['organic_results'];
              final List<AmazonProduct> products = organicResults
                  .map<AmazonProduct>((json) => AmazonProduct.fromJson(json))
                  .toList();
              return products;
            } else {
              print("No product results found.");
              return []; // Return an empty list if no products found
            }
          } catch (e) {
            print(e.toString());
            Get.snackbar("Error", e.toString());
          }
        }
      } catch (e) {
        print(e.toString());
        Get.snackbar("Error", e.toString());
      }
    }
    return null;
  }

  static Future<Product?> getProductDetails(String asin) async {
    final uri = Uri.parse(
        'https://www.searchapi.io/api/v1/search?api_key=g1frYMnX55eSXczx2qY5S6UF&amazon_domain=amazon.in&engine=amazon_product&asin=$asin');

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        try {
          final decodedJson = jsonDecode(response.body);
          if (decodedJson.containsKey('product')) {
            final productData = decodedJson['product'];
            print('Product Data: $productData'); // Debugging line

            // Ensure productData is a Map<String, dynamic>
            if (productData is Map<String, dynamic>) {
              final result = Product.fromJson(productData);
              return result;
            } else {
              print('Product data is not a Map<String, dynamic>');
              return null;
            }
          } else {
            print('No product key found in JSON');
            return null;
          }
        } catch (e) {
          print(e.toString());
          Get.snackbar("Error", e.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error", e.toString());
    }
    return null;
  }
}
