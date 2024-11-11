import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import '../../../data/models/detail_surah.dart';

class DetailSurahScreenController extends GetxController {
  final player = AudioPlayer();

  Verse? lastVerse;

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData["data"] != null) {
        return DetailSurah.fromJson(jsonData);
      } else {
        throw Exception("Data Surah tidak tersedia");
      }
    } else {
      throw Exception("Gagal mengambil data surah");
    }
  }

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
}
