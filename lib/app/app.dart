import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzel_teste/app/modules/login/ui/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData(
        accentColor: Colors.white,
        primaryColor: Colors.orange[900],
        scaffoldBackgroundColor: Colors.grey[300],
      ),
    );
  }
}