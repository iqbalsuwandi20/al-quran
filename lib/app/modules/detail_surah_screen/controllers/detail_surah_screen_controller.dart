import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/databases/bookmark.dart';
import '../../../data/models/detail_surah.dart' as detail;

class DetailSurahScreenController extends GetxController {
  final player = AudioPlayer();

  RxBool isLoading = false.obs;

  detail.Verse? lastVerse;

  DatabaseManager database = DatabaseManager.instance;

  void addBookmark(bool lastRead, detail.DetailSurah surah, detail.Verse ayat,
      int indexAyat) async {
    Database db = await database.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          where:
              "surah = '${surah.data.name.transliteration.id}' and ayat = ${ayat.number.inSurah} and juz = ${ayat.meta.juz} and via = 'surah' and index_ayat = $indexAyat and last_read = 0");
      if (checkData.isNotEmpty) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert(
        "bookmark",
        {
          "surah": surah.data.name.transliteration.id,
          "ayat": ayat.number.inSurah,
          "juz": ayat.meta.juz,
          "via": "surah",
          "index_ayat": indexAyat,
          "last_read": lastRead == true ? 1 : 0,
        },
      );

      Get.back();

      Get.snackbar(
        "Sukses".toUpperCase(),
        "sukses menambah penanda...",
        backgroundColor: Colors.pink[300],
        colorText: Colors.white,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        icon: Icon(
          Icons.bookmark_added_outlined,
          color: Colors.white,
        ),
        shouldIconPulse: true,
        duration: Duration(seconds: 5),
        forwardAnimationCurve: Curves.easeOut,
        reverseAnimationCurve: Curves.easeIn,
        snackStyle: SnackStyle.FLOATING,
        titleText: Text(
          "Sukses".toUpperCase(),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        messageText: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'sukses menambah penanda...',
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              speed: Duration(milliseconds: 200),
            ),
          ],
          totalRepeatCount: 1,
          onFinished: () {
            Get.closeCurrentSnackbar();
          },
        ),
      );
    } else {
      Get.back();

      Get.snackbar(
        "gagal".toUpperCase(),
        "gagal penanda sudah ada...",
        backgroundColor: Colors.red[300],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        icon: Icon(
          Icons.error_outline_outlined,
          color: Colors.white,
        ),
        shouldIconPulse: true,
        duration: Duration(seconds: 5),
        forwardAnimationCurve: Curves.easeOut,
        reverseAnimationCurve: Curves.easeIn,
        snackStyle: SnackStyle.FLOATING,
        titleText: Text(
          "gagal".toUpperCase(),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        messageText: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'gagal penanda sudah ada...',
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              speed: Duration(milliseconds: 200),
            ),
          ],
          totalRepeatCount: 1,
          onFinished: () {
            Get.closeCurrentSnackbar();
          },
        ),
      );
    }

    var data = await db.query("bookmark");
    print(data);
  }

  Future<detail.DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData["data"] != null) {
        return detail.DetailSurah.fromJson(jsonData);
      } else {
        throw Exception("Data Surah tidak tersedia");
      }
    } else {
      throw Exception("Gagal mengambil data surah");
    }
  }

  void stopAudio(detail.Verse verse) async {
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

  void resumeAudio(detail.Verse verse) async {
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

  void pauseAudio(detail.Verse verse) async {
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

  void playAudio(detail.Verse verse) async {
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
