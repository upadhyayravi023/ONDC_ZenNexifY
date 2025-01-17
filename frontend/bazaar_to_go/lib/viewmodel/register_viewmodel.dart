import 'dart:convert';

import 'package:bazaar_to_go/model/add_details.dart';
import 'package:bazaar_to_go/repository/endpoint.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../repository/api_service.dart';

class RegisterViewmodel {
  static Future<List<PostOffice>?> fetchPostOffices(String postalCode) async {
    if (postalCode.isNotEmpty && postalCode.length == 6) {
      try {
        final http.Response response =
            await ApiService.get(Endpoint.getAddress, postalCode);

        if (response.statusCode == 200) {
          try {
            final decodedJson = jsonDecode(response.body);

            // Check if the response contains 'PostOffice' key and it is a list
            if (decodedJson.containsKey('PostOffice') &&
                decodedJson['PostOffice'] is List) {
              final List<dynamic> postOfficeJsonList =
                  decodedJson['PostOffice'];
              return postOfficeJsonList
                  .map((json) => PostOffice.fromJson(json))
                  .toList();
            } else {
              Get.snackbar("Error", "Invalid pin code");
              return null;
            }
          } catch (e) {
            print(e.toString());
            return null;
          }
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
