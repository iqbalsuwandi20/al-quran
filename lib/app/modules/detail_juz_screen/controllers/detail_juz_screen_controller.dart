import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/models/juz.dart';
import '../../../data/models/surah.dart';

class DetailJuzScreenController extends GetxController {
  final Map<int, int> surahIndexMap = {};

  int index = 0;

  final player = AudioPlayer();

  Verse? lastVerse;

  void stopAudio(Verse verse) async {
    try {
      await player.stop();
      verse.audioCondition = "stop";
      update();
    } on PlayerException catch (e) {
      // ignore: avoid_print
      print("Error code: ${e.code}");
      // ignore: avoid_print
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      // ignore: avoid_print
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // ignore: avoid_print
      print('An error occured: $e');
    }
  }

  void resumeAudio(Verse verse) async {
    try {
      verse.audioCondition = "playing";
      update();
      await player.play();
      verse.audioCondition = "stop";
      update();
    } on PlayerException catch (e) {
      // ignore: avoid_print
      print("Error code: ${e.code}");
      // ignore: avoid_print
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      // ignore: avoid_print
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // ignore: avoid_print
      print('An error occured: $e');
    }
  }

  void pauseAudio(Verse verse) async {
    try {
      await player.pause();
      verse.audioCondition = "pause";
      update();
    } on PlayerException catch (e) {
      // ignore: avoid_print
      print("Error code: ${e.code}");
      // ignore: avoid_print
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      // ignore: avoid_print
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // ignore: avoid_print
      print('An error occured: $e');
    }
  }

  void playAudio(Verse verse) async {
    try {
      lastVerse ??= verse;
      lastVerse?.audioCondition = "stop";
      lastVerse = verse;
      lastVerse!.audioCondition = "stop";
      update();

      await player.stop();
      await player.setUrl(verse.audio.primary);

      verse.audioCondition = "playing";
      update();
      await player.play();

      verse.audioCondition = "stop";
      await player.stop();
      update();
    } on PlayerException catch (e) {
      // ignore: avoid_print
      print("Error code: ${e.code}");
      // ignore: avoid_print
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      // ignore: avoid_print
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // ignore: avoid_print
      print('An error occured: $e');
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }

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
