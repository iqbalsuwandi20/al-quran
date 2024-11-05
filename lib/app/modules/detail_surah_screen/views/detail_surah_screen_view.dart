import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_screen_controller.dart';

class DetailSurahScreenView extends GetView<DetailSurahScreenController> {
  const DetailSurahScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailSurahScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailSurahScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
