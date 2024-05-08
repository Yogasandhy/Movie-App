import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'https://api.themoviedb.org/3';
const String apiKey = 'YOUR_API_KEY';

Future<void> register(String username, String password, String email) async {
  final response = await http.post(
    Uri.parse('$baseUrl/account'),
    body: {
      'username': username,
      'password': password,
      'email': email,
      'api_key': apiKey,
    },
  );

  if (response.statusCode == 200) {
    print('Registration successful');
  } else {
    throw Exception('Failed to register');
  }
}

Future<void> login(String username, String password) async {
  final response = await http.get(
    Uri.parse('$baseUrl/authentication/token/new?api_key=$apiKey'),
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final requestToken = jsonResponse['request_token'];

    final loginResponse = await http.post(
      Uri.parse('$baseUrl/authentication/token/validate_with_login?api_key=$apiKey'),
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );

    if (loginResponse.statusCode == 200) {
      print('Login successful');
    } else {
      throw Exception('Failed to login');
    }
  } else {
    throw Exception('Failed to get request token');
  }
}
