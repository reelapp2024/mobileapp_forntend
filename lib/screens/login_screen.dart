import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logical_dottech/constant/color_const.dart';
import 'package:logical_dottech/constant/image_const.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // App Logo
                          Image.asset(
                            AppAssets.logo,
                            scale: 2.5,
                          ),

                          // Welcome Text
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: TextStyle(fontSize: 24),
                              children: [
                                TextSpan(
                                  text: 'Welcome to\n',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 34,
                                  ),
                                ),
                                TextSpan(
                                  text: 'LOCAL SHOP',
                                  style: TextStyle(
                                    color: AppColors.primary1Color,
                                    fontFamily: 'Montserrat',
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),

                          // Email Field
                          TextFormField(
                            cursorColor: AppColors.primaryColor,
                            onChanged: (value) =>
                                authController.email.value = value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              labelText: 'Email or Phone Number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email or phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Password Field
                          TextFormField(
                            onChanged: (value) =>
                                authController.password.value = value,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Login Button
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                authController.loginWithEmail();
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Color(0xff282828),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Sign Up Navigation
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Don’t have an account? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed('/signup');
                                    },
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
