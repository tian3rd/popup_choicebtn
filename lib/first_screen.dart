import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/compliance_controller.dart';

class FirstScreen extends GetView<ComplianceController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(
              child: Text(
                "Dialog button",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                controller.showMultiCheck();
              }
          ),
        ),
      ),
    );
  }
}