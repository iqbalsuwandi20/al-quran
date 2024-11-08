import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_screen_controller.dart';

class DetailJuzScreenView extends GetView<DetailJuzScreenController> {
  const DetailJuzScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailJuzScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailJuzScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
