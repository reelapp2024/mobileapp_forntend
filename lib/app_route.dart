import 'package:get/get.dart';
import 'package:logical_dottech/screens/content_create.dart';
import 'package:logical_dottech/screens/create_profile.dart';
import 'package:logical_dottech/screens/get_otp_screen.dart';
import 'package:logical_dottech/screens/login_screen.dart';
import 'package:logical_dottech/screens/mainscreen.dart';
import 'package:logical_dottech/screens/profilescreen.dart';
import 'package:logical_dottech/screens/reel_screen.dart';
import 'package:logical_dottech/screens/selectBusinesType.dart';
import 'package:logical_dottech/screens/signup_screen.dart';
import 'package:logical_dottech/screens/splash_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String getOtp = '/getOtp';
  static const String signup = '/signup';
  static const String splashscreen = '/splashscreen';
  static const String selectBustype = '/selectBustype';
  static const String profilescreen = '/profilescreen';
  static const String mainscreen = '/mainscreen';
  static const String reelscreen = '/reelscreen';
  static const String createprofile = '/createprofile';
  static const String contentCreateScreen = '/contentCreateScreen';

  static final routes = [
    GetPage(name: signup, page: () => SignupScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: getOtp, page: () => GetOtpScreen()),
    GetPage(name: splashscreen, page: () => SplashScreen()),
    GetPage(name: selectBustype, page: () => BusinessTypeScreen()),
    GetPage(name: mainscreen, page: () => MainScreen()),
    GetPage(name: profilescreen, page: () => ProfileScreen()),
    GetPage(name: contentCreateScreen, page: () => ContentCreateScreen()),
    GetPage(
      name: reelscreen,
      page: () {
        // Retrieve arguments with null checks
        final initialVideoUrl = Get.arguments['videoUrl'] ?? '';
        final username = Get.arguments['username'] ?? 'Unknown User';
        final caption = Get.arguments['caption'] ?? '';
        final likes = Get.arguments['likes'] ?? '0';
        final comments = Get.arguments['comments'] ?? '0';
        final views = Get.arguments['views'] ?? '0'; // Add views argument

        return ReelScrollingScreen(
          initialVideoUrl: initialVideoUrl,
          username: username,
          caption: caption,
          likes: likes,
          comments: comments,
          views: views, // Pass views to ReelScrollingScreen
        );
      },
    ),
    GetPage(name: createprofile, page: () => CreateProfileScreen()),
  ];
}
