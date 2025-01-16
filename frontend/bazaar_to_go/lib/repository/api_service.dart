import 'dart:convert';
import 'package:bazaar_to_go/repository/endpoint.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> get(Endpoint endpoint, String? paramater) async {
    final url = Uri.parse('${endpoint.getUrl()}$paramater');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$endpoint');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to post data');
    }
  }
}
