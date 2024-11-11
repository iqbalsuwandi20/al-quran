import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import '../../../data/models/detail_surah.dart';

class DetailSurahScreenController extends GetxController {
  final player = AudioPlayer();

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

  void playAudio(String? url) async {
    if (url != null) {
      try {
        await player.setUrl(url);
        await player.play();
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
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
