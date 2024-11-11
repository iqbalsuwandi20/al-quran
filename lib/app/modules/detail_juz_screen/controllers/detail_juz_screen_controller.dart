import 'package:get/get.dart';

import '../../../data/models/juz.dart';
import '../../../data/models/surah.dart';

class DetailJuzScreenController extends GetxController {
  final Map<int, int> surahIndexMap = {};
  int index = 0;

  void initializeSurahIndexMap(Juz detailJuz, List<Surah> allSurahInThisJuz) {
    int currentSurahIndex = 0;
    for (int i = 0; i < detailJuz.data.verses.length; i++) {
      final verse = detailJuz.data.verses[i];
      if (verse.number.inSurah == 1 &&
          currentSurahIndex < allSurahInThisJuz.length) {
        currentSurahIndex++;
      }
      surahIndexMap[i] = currentSurahIndex - 1;
    }
  }

  @override
  void onInit() {
    super.onInit();
    final Juz detailJuz = Get.arguments["juz"];
    final List<Surah> allSurahInThisJuz = Get.arguments["surah"];
    initializeSurahIndexMap(detailJuz, allSurahInThisJuz);
  }
}
