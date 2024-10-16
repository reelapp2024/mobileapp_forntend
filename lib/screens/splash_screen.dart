import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logical_dottech/constant/image_const.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    // Delay for 2 seconds before starting the fade out
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isVisible = false; // Fade out splash screen content
      });
      // Delay for an additional 500 milliseconds for the fade out to complete
      Future.delayed(Duration(milliseconds: 500), () {
        Get.off(() => LoginScreen()); // Use a lambda function for navigation
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F0F0F),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0, // Control visibility
          duration: Duration(milliseconds: 500), // Fade duration
          // child: Text(
          //   'Splash Screen',
          //   style: TextStyle(fontSize: 24, color: Colors.white),
          // ),
          child: Image.asset(
            AppAssets.applogo,
            scale: 2,
          ),
        ),
      ),
    );
  }
}
