import 'package:get/get.dart';

import '../controllers/detail_surah_screen_controller.dart';

class DetailSurahScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSurahScreenController>(
      () => DetailSurahScreenController(),
    );
  }
}
