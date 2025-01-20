import 'dart:convert';
import 'package:bazaar_to_go/repository/endpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiService {
  static Future<http.Response> get(Endpoint endpoint, String? paramater) async {
    final url = Uri.parse('${endpoint.getUrl()}$paramater');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<http.Response> post(String endpoint,
      Map<String, dynamic> data) async {
    final url = Uri.parse(endpoint);
    print(url.toString());
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    print(jsonEncode(data));
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to post data');
    }
  }


  static Future<http.Response> delete(String endpoint,
      Map<String, dynamic> data) async {
    final url = Uri.parse(endpoint);
    print(url.toString());
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data), // Pass data if necessary, like an ID for deletion
    );
    print(jsonEncode(data)); // Print the data being sent in the request
    print(response.body); // Print the response body for debugging

    if (response.statusCode == 200 || response.statusCode == 204) {
      return response; // Return response if successful (204 No Content is common for successful deletes)
    } else {
      throw Exception('Failed to delete data');
    }
  }
}