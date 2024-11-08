import 'package:get/get.dart';

import '../controllers/detail_juz_screen_controller.dart';

class DetailJuzScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailJuzScreenController>(
      () => DetailJuzScreenController(),
    );
  }
}
