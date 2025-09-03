import 'package:http/http.dart' as http;
import 'dart:convert';
import '../error/exceptions.dart';

class ApiClient {
  final http.Client client;
  
  ApiClient({required this.client});
  
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await client.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ServerException('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw NetworkException('Network error occurred: $e');
    }
  }
}
