import 'dart:convert';
import 'dart:io';
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

  // Verify OTP API
  Future<Map<String, dynamic>> verifyOtp({
    required String otp,
    required int type,
  }) async {
    final String verifyOtpEndpoint = '/verify_otp'; // Endpoint path
    final url = Uri.parse('$_baseUrl$verifyOtpEndpoint');
    final body = jsonEncode({
      'otp': otp,
      'type': type,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('OTP verification error: $e');
    }
  }

// Send 2FA OTP API
  Future<Map<String, dynamic>> send2FAOtp({
    required String userId,
    required String deviceToken,
    required int deviceType,
  }) async {
    final String send2FAOtpEndpoint = '/send2FAOTP'; // Endpoint path
    final url = Uri.parse('$_baseUrl$send2FAOtpEndpoint');
    final body = jsonEncode({
      'userId': userId,
      'deviceToken': deviceToken,
      'deviceType': deviceType,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Error sending 2FA OTP: $e');
    }
  }

  // Verify 2FA OTP API
  Future<Map<String, dynamic>> verify2FAOtp({
    required String otp,
    required String userId,
    required String deviceToken,
    required int deviceType,
  }) async {
    final String verify2FAOtpEndpoint = '/verify_2FAotp'; // Endpoint path
    final url = Uri.parse('$_baseUrl$verify2FAOtpEndpoint');
    final body = jsonEncode({
      'otp': otp,
      'userId': userId,
      'deviceToken': deviceToken,
      'deviceType': deviceType,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Error verifying 2FA OTP: $e');
    }
  }

// Add Business Location API
  Future<Map<String, dynamic>> addBusinessLocation({
    required String buildingNo,
    required String street,
    required String city,
    required String state,
    required String pincode,
    required double lat,
    required double lng,
    required String district,
    required String country,
    required String businessId,
  }) async {
    final String addBusinessLocationEndpoint =
        '/add_business_location'; // Endpoint path
    final url = Uri.parse('$_baseUrl$addBusinessLocationEndpoint');
    final body = jsonEncode({
      'building_no': buildingNo,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'lat': lat,
      'lng': lng,
      'district': district,
      'country': country,
      'business_id': businessId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Error adding business location: $e');
    }
  }

// Assign Area to Business API
  Future<Map<String, dynamic>> assignAreaToBusiness({
    required String city,
    required String state,
    required String pincode,
    required double lat,
    required double lng,
    required String district,
    required String country,
    required String businessId,
  }) async {
    final String assignAreaToBusinessEndpoint =
        '/assign_area_to_business'; // Endpoint path
    final url = Uri.parse('$_baseUrl$assignAreaToBusinessEndpoint');
    final body = jsonEncode({
      'city': city,
      'state': state,
      'pincode': pincode,
      'lat': lat,
      'lng': lng,
      'district': district,
      'country': country,
      'business_id': businessId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Error assigning area to business: $e');
    }
  }

// Add Business Review API
  Future<Map<String, dynamic>> addBusinessReview({
    required String review,
    required double rating,
    required String businessId,
  }) async {
    final String addBusinessReviewEndpoint =
        '/add_business_review'; // Endpoint path
    final url = Uri.parse('$_baseUrl$addBusinessReviewEndpoint');
    final body = jsonEncode({
      'review': review,
      'rating': rating,
      'business_id': businessId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Error adding business review: $e');
    }
  }

// Reply to Review API
  Future<Map<String, dynamic>> replyToReview({
    required String reviewId,
    required String response,
  }) async {
    final String replyToReviewEndpoint = '/reply_to_review'; // Endpoint path
    final url = Uri.parse('$_baseUrl$replyToReviewEndpoint');
    final body = jsonEncode({
      'review_id': reviewId,
      'response': response,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Error replying to review: $e');
    }
  }

  Future<Map<String, dynamic>> addPostComment({
    required String postId,
    required String commentText,
    String? parentCommentId, // Optional field
    File? media, // Optional media file
  }) async {
    final String addPostCommentEndpoint = '/add_post_comment'; // Endpoint path
    final url = Uri.parse('$_baseUrl$addPostCommentEndpoint');

    try {
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields['post_id'] = postId
        ..fields['comment_text'] = commentText;

      if (parentCommentId != null) {
        request.fields['parent_comment_id'] = parentCommentId;
      }

      if (media != null) {
        final mediaStream = http.ByteStream(media.openRead());
        final mediaLength = await media.length();
        final multipartFile = http.MultipartFile(
          'media',
          mediaStream,
          mediaLength,
          filename: media.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody);
      } else {
        final errorResponse = await response.stream.bytesToString();
        throw Exception(jsonDecode(errorResponse)['message']);
      }
    } catch (e) {
      throw Exception('Error adding post comment: $e');
    }
  }

// Like/Dislike Comment API
  Future<Map<String, dynamic>> likeDislikeComment({
    required String commentId,
    required int action, // 1 for Like, 0 for Dislike
  }) async {
    final String likeDislikeCommentEndpoint =
        '/like_dislike_comment'; // Endpoint path
    final url = Uri.parse('$_baseUrl$likeDislikeCommentEndpoint');
    final body = jsonEncode({
      'comment_id': commentId,
      'action': action,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Error in like/dislike comment: $e');
    }
  }

// Follow/Unfollow API
  Future<Map<String, dynamic>> followUnfollow({
    required String followedId,
    required int action, // 1 for Follow, 0 for Unfollow
    required String followedType, // e.g., "Business"
  }) async {
    final String followUnfollowEndpoint = '/follow_unfollow'; // Endpoint path
    final url = Uri.parse('$_baseUrl$followUnfollowEndpoint');
    final body = jsonEncode({
      'followed_id': followedId,
      'action': action,
      'followed_type': followedType,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Error in follow/unfollow: $e');
    }
  }

// Fetch Business Details API
  Future<Map<String, dynamic>> fetchBusinessDetails({
    required String businessId,
  }) async {
    final String fetchBusinessDetailsEndpoint =
        '/fetch_business_details'; // Endpoint path
    final url = Uri.parse('$_baseUrl$fetchBusinessDetailsEndpoint');
    final body = jsonEncode({
      'business_id': businessId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Error fetching business details: $e');
    }
  }

// Fetch Business Posts API
  Future<Map<String, dynamic>> fetchBusinessPosts({
    required int page,
    required int limit,
  }) async {
    final String fetchBusinessPostsEndpoint =
        '/fetch_business_posts'; // Endpoint path
    final url = Uri.parse(
        '$_baseUrl$fetchBusinessPostsEndpoint?page=$page&limit=$limit');

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception('Error fetching business posts: $e');
    }
  }

  // Logout API
  Future<void> logout() async {
    await _removeToken();
  }
}
