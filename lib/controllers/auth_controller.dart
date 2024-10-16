import 'package:get/get.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;
  var isLoading = false.obs; // Track loading state
  var errorMessage = ''.obs; // Track error messages

  var selectedBusinessType = ''.obs;

  void selectBusinessType(String type) {
    selectedBusinessType.value = type;
  }

  void login() {
    // Implement login functionality with error handling
    isLoading.value = true; // Set loading state

    // Simulating a login operation
    Future.delayed(Duration(seconds: 2), () {
      // On successful login, navigate to another screen
      isLoading.value = false; // Stop loading

      // Use Get.offNamed('/getOtp') if login is successful
      Get.offNamed('/getOtp'); // Navigate to GetOtpScreen
    });
  }

  void signup() {
    // Implement signup functionality with error handling
  }

  void loginwithotp() {
    // Implement OTP login functionality
    // For example, validate phone number and send OTP
    if (phoneNumber.value.isNotEmpty) {
      // Simulate sending OTP
      Get.snackbar('OTP Sent', 'An OTP has been sent to ${phoneNumber.value}');
    } else {
      errorMessage.value = 'Please enter a valid phone number';
    }
  }
}
