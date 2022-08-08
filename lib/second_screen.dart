import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'first_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // onPressed: () => Get.to(() => FirstScreen()),
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => FirstScreen())),
        ),
      ),
    );
  }
}
