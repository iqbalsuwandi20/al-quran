import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/introduction_screen_controller.dart';

class IntroductionScreenView extends GetView<IntroductionScreenController> {
  const IntroductionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Ayo Membaca Al-Qur'an",
              style: TextStyle(
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                "Sesibuk itukah kamu sampai belum membaca Al-Qur'an hari ini?",
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  color: Colors.black54,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Center(
              child: SizedBox(
                width: size.width * 0.6,
                height: size.width * 0.6,
                child: Lottie.asset("assets/lotties/introduction.json"),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  elevation: 6,
                  shadowColor: Colors.pinkAccent.withOpacity(0.4),
                ),
                onPressed: () => Get.offAllNamed(Routes.HOME),
                child: Text(
                  "MULAI",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
