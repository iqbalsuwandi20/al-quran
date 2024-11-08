import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/search_screen_controller.dart';

class SearchScreenView extends GetView<SearchScreenController> {
  const SearchScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PENCARIAN SURAH',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[700],
        elevation: 10,
        shadowColor: Colors.pink[200],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Icon(
              Icons.arrow_back_ios_new,
              key: ValueKey<int>(1),
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'SearchScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
