import 'package:get/get.dart';
import 'package:logical_dottech/screens/get_otp_screen.dart';
import 'package:logical_dottech/screens/login_screen.dart';
import 'package:logical_dottech/screens/selectBusinesType.dart';
import 'package:logical_dottech/screens/signup_screen.dart';
import 'package:logical_dottech/screens/splash_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String getOtp = '/getOtp';
  static const String signup = '/signup';
  static const String splashscreen = '/splashscreen';
  static const String selectBustype = '/selectBustype';

  static final routes = [
    GetPage(name: signup, page: () => SignupScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: getOtp, page: () => GetOtpScreen()),
    GetPage(name: splashscreen, page: () => SplashScreen()),
    GetPage(name: selectBustype, page: () => BusinessTypeScreen()),
  ];
}
