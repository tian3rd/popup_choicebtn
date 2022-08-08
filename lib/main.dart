import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/compliance_controller.dart';
import 'first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final controller = Get.put(ComplianceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstScreen(),
    );
  }
}