import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:math';

import 'package:logical_dottech/constant/color_const.dart'; // Import for random OTP generation

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isOtpButtonVisible = false;

  // Focus nodes for OTP fields
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());

  // Variable to store the generated OTP
  String _generatedOtp = '';

  @override
  void dispose() {
    // Dispose controllers and focus nodes to free up resources
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _otpFocusNodes.forEach((node) => node.dispose());
    _otpControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF2222), Color.fromARGB(255, 67, 21, 18)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          // Title "Sign Up"
          Positioned(
            top: 60,
            left: 16,
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          // White form container
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Fill up your details to create an account.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Form fields
                    _buildTextField(
                        'Username', Icons.person, _usernameController),
                    SizedBox(height: 10),
                    _buildTextField('Email', Icons.email, _emailController),
                    SizedBox(height: 10),
                    _buildTextField(
                        'Phone Number', Icons.phone, _phoneController),
                    SizedBox(height: 10),
                    _buildTextField(
                        'Create Password', Icons.lock, _passwordController,
                        isObscure: true),
                    SizedBox(height: 20),
                    // OTP Button
                    if (_isOtpButtonVisible) ...[
                      Center(
                        child: ElevatedButton(
                          onPressed: _getOtp,
                          child: Text(
                            'Get OTP',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFFFF2222), // Background color
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                    // Register Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the login screen
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xFFFF2222), // Background color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to get OTP
  void _getOtp() {
    if (_emailController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
      // Generate OTP and send it to both email and phone
      _generatedOtp = _generateOtp(); // Generate the OTP
      _sendOtpEmail(_emailController.text, _generatedOtp); // Send OTP to email
      _sendOtpSms(_phoneController.text, _generatedOtp); // Send OTP to phone

      // Show OTP dialog after sending OTP
      _showOtpDialog();
    } else {
      _showError('Please enter both email and phone number.');
    }
  }

  // Method to generate a random OTP
  String _generateOtp() {
    final random = Random();
    int otp = 100000 + random.nextInt(900000); // Generate a 6-digit OTP
    return otp.toString();
  }

  // Method to send OTP via email (mockup)
  void _sendOtpEmail(String email, String otp) {
    // Implement your email sending logic here (e.g., using an API)
    print('Sending OTP $otp to email: $email');
  }

  // Method to send OTP via SMS (mockup)
  void _sendOtpSms(String phone, String otp) {
    // Implement your SMS sending logic here (e.g., using an API)
    print('Sending OTP $otp to phone: $phone');
  }

  // Method to show error messages
  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Method to show OTP dialog
  void _showOtpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            width: 300,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/OTP 1.png',
                  height: 100,
                ),
                SizedBox(height: 20),
                Text(
                  'Enter the OTP sent to your phone',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return _otpTextField(index);
                  }),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // _openOlaMap(); // Open Ola Map on submit
                    Get.toNamed('/selectBustype');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary1Color,
                  ),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      _otpFocusNodes.forEach((node) => node.unfocus());
    });
  }

  Widget _otpTextField(int index) {
    return Container(
      width: 50,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        focusNode: _otpFocusNodes[index],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: '*',
        ),
        maxLength: 1, // Limit to 1 character
        onChanged: (value) {
          if (value.length == 1) {
            // Move focus to the next field if a digit is entered
            if (index < 3) {
              _otpFocusNodes[index + 1]
                  .requestFocus(); // Move focus to the next field
            } else {
              // If it's the last field, you might want to handle submission or focus out
              FocusScope.of(context)
                  .unfocus(); // Unfocus if it's the last field
            }
          } else if (value.isEmpty && index > 0) {
            // Move focus back to the previous field if deleted
            _otpFocusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  // A reusable method for building TextFields
  Widget _buildTextField(
      String labelText, IconData icon, TextEditingController controller,
      {bool isObscure = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _isOtpButtonVisible = _emailController.text.isNotEmpty &&
              _phoneController.text.isNotEmpty;
        });
      },
    );
  }
}
