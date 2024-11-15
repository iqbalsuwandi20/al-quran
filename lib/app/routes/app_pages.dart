import 'package:get/get.dart';

import '../modules/detail_juz_screen/bindings/detail_juz_screen_binding.dart';
import '../modules/detail_juz_screen/views/detail_juz_screen_view.dart';
import '../modules/detail_surah_screen/bindings/detail_surah_screen_binding.dart';
import '../modules/detail_surah_screen/views/detail_surah_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction_screen/bindings/introduction_screen_binding.dart';
import '../modules/introduction_screen/views/introduction_screen_view.dart';
import '../modules/last_read_screen/bindings/last_read_screen_binding.dart';
import '../modules/last_read_screen/views/last_read_screen_view.dart';
import '../modules/search_screen/bindings/search_screen_binding.dart';
import '../modules/search_screen/views/search_screen_view.dart';

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
    GetPage(
      name: _Paths.SEARCH_SCREEN,
      page: () => const SearchScreenView(),
      binding: SearchScreenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LAST_READ_SCREEN,
      page: () => const LastReadScreenView(),
      binding: LastReadScreenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DETAIL_JUZ_SCREEN,
      page: () => DetailJuzScreenView(),
      binding: DetailJuzScreenBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
