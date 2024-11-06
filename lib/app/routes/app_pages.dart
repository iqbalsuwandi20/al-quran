import 'package:get/get.dart';

import '../modules/detail_surah_screen/bindings/detail_surah_screen_binding.dart';
import '../modules/detail_surah_screen/views/detail_surah_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction_screen/bindings/introduction_screen_binding.dart';
import '../modules/introduction_screen/views/introduction_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.INTRODUCTION_SCREEN,
      page: () => const IntroductionScreenView(),
      binding: IntroductionScreenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DETAIL_SURAH_SCREEN,
      page: () => DetailSurahScreenView(),
      binding: DetailSurahScreenBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
