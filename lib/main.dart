import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logical_dottech/app_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.red,
      ),
      initialRoute: AppRoutes.profilescreen, // Use the route from AppRoutes
      getPages: AppRoutes.routes, // Use the routes defined in AppRoutes
    );
  }
}
