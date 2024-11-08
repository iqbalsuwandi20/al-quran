import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/last_read_screen_controller.dart';

class LastReadScreenView extends GetView<LastReadScreenController> {
  const LastReadScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LastReadScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LastReadScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
