import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:logical_dottech/constant/color_const.dart'; // Import for colors
import 'package:logical_dottech/services/api_service.dart'; // Import your API service

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
  String _selectedCountryCode = '+1'; // Default country code

  // Focus nodes for OTP fields
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());

  // Variable to store the generated OTP
  String _generatedOtp = '';

  @override
  void dispose() {
    // Dispose controllers and focus nodes
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
                    _buildPhoneInput(),
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
                        onPressed: _registerUser,
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

  Widget _buildPhoneInput() {
    return Row(
      children: [
        // Country code dropdown
        DropdownButton<String>(
          value: _selectedCountryCode,
          items: ['+1', '+91', '+44', '+61', '+81']
              .map((code) => DropdownMenuItem(
                    value: code,
                    child: Text(code),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedCountryCode = value!;
              _isOtpButtonVisible = _emailController.text.isNotEmpty &&
                  _phoneController.text.isNotEmpty;
            });
          },
        ),
        SizedBox(width: 10),
        // Phone number input
        Expanded(
          child: TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _isOtpButtonVisible = _emailController.text.isNotEmpty &&
                    _phoneController.text.isNotEmpty;
              });
            },
          ),
        ),
      ],
    );
  }

  // Method to handle OTP
  void _getOtp() {
    if (_emailController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
      _generatedOtp = _generateOtp(); // Generate OTP
      _sendOtpEmail(_emailController.text, _generatedOtp); // Mock sending OTP
      _sendOtpSms(_phoneController.text, _generatedOtp); // Mock sending OTP

      _showOtpDialog(); // Show OTP dialog
    } else {
      _showError('Please enter both email and phone number.');
    }
  }

  // Method to register user
  Future<void> _registerUser() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showError('All fields are required.');
      return;
    }

    try {
      // Call the API to register user
      final apiService = ApiService(); // Create an instance of ApiService
      final response = await apiService.addUser(
        username: _usernameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        countryCode: _selectedCountryCode, // Pass the selected country code
        password: _passwordController.text,
      );

      if (response['success']) {
        _showSuccess('Registration successful!');
        Get.toNamed('/login'); // Navigate to login screen
      } else {
        _showError(response['message'] ?? 'Registration failed.');
      }
    } catch (e) {
      _showError('Error: $e');
    }
  }

  // Show error snackbar
  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Show success snackbar
  void _showSuccess(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Generate OTP
  String _generateOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // Mock OTP email sending
  void _sendOtpEmail(String email, String otp) {
    print('Sending OTP $otp to email: $email');
  }

  // Mock OTP SMS sending
  void _sendOtpSms(String phone, String otp) {
    print('Sending OTP $otp to phone: $phone');
  }

  // Show OTP dialog
  void _showOtpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter OTP sent to your phone'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, _otpTextField),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  // OTP text field builder
  Widget _otpTextField(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(border: OutlineInputBorder()),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 3) _otpFocusNodes[index + 1].requestFocus();
          } else if (index > 0) {
            _otpFocusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  // Text field builder
  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isObscure = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
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
