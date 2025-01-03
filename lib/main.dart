import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logical_dottech/app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.red,
      ),
      initialRoute: AppRoutes.businessVerifyDocumentScreen,
      getPages: AppRoutes.routes,
    );
  }
}
