import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String _baseUrl = 'http://nodejs.logicaldottech.com/api/v1';

  static const String loginEndpoint = '/login';
  static const String signupEndpoint = '/signup';
  static const String deleteUserEndpoint = '/users/delete';

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Common headers
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // Get token from secure storage
  Future<String?> _getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  // Save token to secure storage
  Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  // Remove token from secure storage
  Future<void> _removeToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  // Auth headers
  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await _getToken();
    if (token == null) throw Exception('Token not found. Please log in.');
    return {
      ...headers,
      'Authorization': 'Bearer $token',
    };
  }

  // Login API
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl$loginEndpoint');
    final body = jsonEncode({'email': email, 'password': password});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['token'] != null) {
          await _saveToken(data['token']);
        }
        return data;
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  // Signup API
  Future<Map<String, dynamic>> addUser({
    required String username,
    required String email,
    required String phone,
    required String password,
    required String countryCode, // New parameter for country code
  }) async {
    final url = Uri.parse('$_baseUrl$signupEndpoint');
    final body = jsonEncode({
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'country_code': countryCode, // Include country code in the payload
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Signup error: $e');
    }
  }

  // Logout API
  Future<void> logout() async {
    await _removeToken();
  }
}
