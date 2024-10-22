import 'package:get/get.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;
  var isLoading = false.obs; // Track loading state
  var errorMessage = ''.obs; // Track error messages

  var selectedBusinessType = ''.obs;

  // Select business type
  void selectBusinessType(String type) {
    selectedBusinessType.value = type;
  }

  // Login with email and password
  void loginWithEmail() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      errorMessage.value = 'Email and password cannot be empty';
      return;
    }

    isLoading.value = true;
    // Simulate login process with a 2-second delay
    await Future.delayed(Duration(seconds: 2), () {
      // Check for success or failure
      if (email.value == "test@example.com" &&
          password.value == "password123") {
        // On success, navigate to another screen
        isLoading.value = false;
        Get.offNamed('/home'); // Navigate to the home screen
      } else {
        // Handle login error
        isLoading.value = false;
        errorMessage.value = 'Invalid email or password';
        Get.snackbar('Login Failed', errorMessage.value);
      }
    });
  }

  // Sign up with email and password
  void signup() async {
    if (email.value.isEmpty ||
        password.value.isEmpty ||
        selectedBusinessType.value.isEmpty) {
      errorMessage.value = 'All fields are required for signup';
      return;
    }

    isLoading.value = true;
    // Simulate signup process
    await Future.delayed(Duration(seconds: 2), () {
      // On success, navigate to the next step
      isLoading.value = false;
      Get.offNamed('/getOtp'); // Navigate to the OTP screen for verification
    });
  }

  // Login with OTP
  void loginWithOtp() {
    if (phoneNumber.value.isEmpty) {
      errorMessage.value = 'Please enter a valid phone number';
      return;
    }

    // Simulate sending OTP
    Get.snackbar('OTP Sent', 'An OTP has been sent to ${phoneNumber.value}');
  }

  // Logout functionality
  void logout() {
    // Simulate a logout process
    isLoading.value = true;
    Future.delayed(Duration(seconds: 1), () {
      // After logout, redirect to the login screen
      isLoading.value = false;
      Get.offAllNamed('/login'); // Navigate to the login screen
    });
  }

  // Generic login method that routes based on selected login type
  void login() {
    if (email.value.isNotEmpty && password.value.isNotEmpty) {
      loginWithEmail(); // Login using email and password
    } else if (phoneNumber.value.isNotEmpty) {
      loginWithOtp(); // Login using phone number and OTP
    } else {
      errorMessage.value = 'Please provide valid credentials';
      Get.snackbar('Login Error', errorMessage.value);
    }
  }

  // Method to validate email format (basic example)
  bool isValidEmail(String email) {
    String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  // Reset the controller state
  void resetFields() {
    email.value = '';
    password.value = '';
    phoneNumber.value = '';
    selectedBusinessType.value = '';
    errorMessage.value = '';
  }
}
