import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart'
    as http; // HTTP client package for making API requests

class ApiService {
  // Base URL for the API
  static const String _baseUrl =
      'https://api.yourapp.com/v1'; // Update to your actual base URL

  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String addUserEndpoint = '/users/add';
  static const String deleteUserEndpoint = '/users/delete';

  // Common headers (modify this based on your API needs)
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // If using token-based authentication, include a method to add authorization headers
  Map<String, String> getAuthHeaders(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  // ==================== Login API ==================== //
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl$loginEndpoint');
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Check if the response status is successful
      if (response.statusCode == 200) {
        // Return the parsed response body
        return jsonDecode(response.body);
      } else {
        // Handle error (like invalid credentials)
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      // Handle other errors (like network issues)
      throw Exception('Login error: $e');
    }
  }

  // ==================== Add User API ==================== //
  Future<Map<String, dynamic>> addUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String token, // Assuming you'll use token for authentication
  }) async {
    final url = Uri.parse('$_baseUrl$addUserEndpoint');
    final body = jsonEncode({
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        headers: getAuthHeaders(token), // Include the token for authorization
        body: body,
      );

      if (response.statusCode == 201) {
        // User created successfully
        return jsonDecode(response.body);
      } else {
        // Handle error (like validation failure)
        throw Exception('Failed to add user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Add user error: $e');
    }
  }

  // ==================== Delete User API ==================== //
  Future<bool> deleteUser({
    required String userId,
    required String token,
  }) async {
    final url = Uri.parse('$_baseUrl$deleteUserEndpoint/$userId');

    try {
      final response = await http.delete(
        url,
        headers: getAuthHeaders(token), // Include the token for authorization
      );

      if (response.statusCode == 200) {
        // User deleted successfully
        return true;
      } else {
        // Handle error (like user not found)
        throw Exception('Failed to delete user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Delete user error: $e');
    }
  }

  // ==================== Helper Functions ==================== //
  // You can add additional helper functions if needed, such as for refreshing tokens, etc.
}
