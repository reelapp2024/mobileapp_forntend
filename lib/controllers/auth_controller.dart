import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  final ApiService apiService = ApiService();

  var email = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;
  var selectedBusinessType = ''.obs;
  var isLoading = false.obs; // Track loading state
  var errorMessage = ''.obs; // Track error messages
  var countryCode = ''.obs; // Observable variable for country code

  // Select business type
  void selectBusinessType(String type) {
    selectedBusinessType.value = type;
  }

  // Validate email format
  bool isValidEmail(String email) {
    String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    return RegExp(emailPattern).hasMatch(email);
  }

  // Reset all fields
  void resetFields() {
    email.value = '';
    password.value = '';
    phoneNumber.value = '';
    selectedBusinessType.value = '';
    errorMessage.value = '';
  }

  // Login with email and password
  Future<void> loginWithEmail() async {
    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = 'Email and password are required.';
      Get.snackbar('Login Error', errorMessage.value);
      return;
    }
    if (!isValidEmail(email.value)) {
      errorMessage.value = 'Please enter a valid email.';
      Get.snackbar('Login Error', errorMessage.value);
      return;
    }

    try {
      isLoading.value = true;

      final response = await apiService.login(email.value, password.value);
      isLoading.value = false;

      if (response.containsKey('token')) {
        Get.snackbar('Success', 'Login successful');
        Get.offAllNamed('/dashboard'); // Navigate to dashboard
      } else {
        errorMessage.value = 'Invalid email or password.';
        Get.snackbar('Login Error', errorMessage.value);
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      Get.snackbar('Login Error', errorMessage.value);
    }
  }

  // Signup method
  Future<void> signup(String username) async {
    if (email.isEmpty ||
        password.isEmpty ||
        phoneNumber.isEmpty ||
        selectedBusinessType.isEmpty ||
        countryCode.isEmpty) {
      errorMessage.value =
          'All fields, including country code, are required for signup.';
      Get.snackbar('Signup Error', errorMessage.value);
      return;
    }

    try {
      isLoading.value = true;
      final response = await apiService.addUser(
        username: username,
        email: email.value,
        phone: phoneNumber.value,
        password: password.value,
        countryCode: countryCode.value, // Pass the country code here
      );
      isLoading.value = false;

      Get.snackbar('Success', 'Signup successful. Verify your account.');
      Get.offNamed('/getOtp'); // Navigate to OTP screen
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      Get.snackbar('Signup Error', errorMessage.value);
    }
  }

  // Logout method
  Future<void> logout() async {
    isLoading.value = true;
    await apiService.logout();
    isLoading.value = false;

    Get.offAllNamed('/login'); // Navigate to login screen
    Get.snackbar('Success', 'Logged out successfully');
  }

  // Login with OTP
  Future<void> loginWithOtp() async {
    if (phoneNumber.isEmpty) {
      errorMessage.value = 'Phone number is required.';
      Get.snackbar('Login Error', errorMessage.value);
      return;
    }

    try {
      Get.snackbar('OTP Sent', 'An OTP has been sent to ${phoneNumber.value}');
      Get.offNamed('/verifyOtp'); // Navigate to OTP verification screen
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('OTP Error', errorMessage.value);
    }
  }
}
