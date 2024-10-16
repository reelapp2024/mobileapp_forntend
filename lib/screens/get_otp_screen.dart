import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logical_dottech/constant/color_const.dart';
import 'package:logical_dottech/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class GetOtpScreen extends StatefulWidget {
  @override
  _GetOtpScreenState createState() => _GetOtpScreenState();
}

class _GetOtpScreenState extends State<GetOtpScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();

  bool isPhoneValid = false;

  // FocusNodes for OTP fields
  final List<FocusNode> _otpFocusNodes =
      List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      setState(() {
        isPhoneValid = phoneController.text.length == 10;
      });
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    ownerNameController.dispose();
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

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

  // Function to open Ola Map
  // void _openOlaMap() async {
  //   String olaMapUrl =
  //       'https://olamaps.com/'; // Replace with a specific URL for Ola Maps if necessary

  //   // Use a different URL scheme for iOS (if applicable)
  //   if (Theme.of(context).platform == TargetPlatform.iOS) {
  //     olaMapUrl =
  //         'ola://'; // Example for a URL scheme to open Ola (replace with actual if available)
  //   }

  //   if (await canLaunch(olaMapUrl)) {
  //     await launch(olaMapUrl);
  //   } else {
  //     throw 'Could not launch $olaMapUrl';
  //   }
  // }

  // Widget for OTP text field
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/OTP 1.png',
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome to LOCAL SHOP',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Enter your Email and Mobile number to get OTP',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Owner’s Name', style: TextStyle(fontFamily: 'Montserrat')),
              SizedBox(height: 5),
              TextField(
                controller: ownerNameController,
                decoration: InputDecoration(
                  hintText: 'Your Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Phone Number', style: TextStyle(fontFamily: 'Montserrat')),
              SizedBox(height: 5),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Email', style: TextStyle(fontFamily: 'Montserrat')),
              SizedBox(height: 5),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary1Color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: isPhoneValid
                      ? () {
                          authController.phoneNumber.value =
                              phoneController.text;
                          authController.email.value = emailController.text;
                          _showOtpDialog(); // Show the OTP dialog
                        }
                      : null,
                  child: Text('Get OTP', style: TextStyle(color: Colors.white)),
                ),
              ),
              Spacer(),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: FloatingActionButton(
              //     onPressed: () {
              //       // Get.toNamed('/selectBustype');
              //     },
              //     backgroundColor: Color(0xFFFF2222),
              //     child: Icon(
              //       Icons.arrow_forward,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
