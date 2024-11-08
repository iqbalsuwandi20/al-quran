import 'package:get/get.dart';

import '../controllers/last_read_screen_controller.dart';

class LastReadScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LastReadScreenController>(
      () => LastReadScreenController(),
    );
  }
}
