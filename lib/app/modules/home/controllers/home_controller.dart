import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../../../data/databases/bookmark.dart';
import '../../../data/models/juz.dart';
import '../../../data/models/surah.dart';

class HomeController extends GetxController {
  var allSurah = <Surah>[].obs;

  RxBool isLoading = false.obs;
  var selectedIndex = Rxn<int>();

  DatabaseManager database = DatabaseManager.instance;

  Future<Map<String, dynamic>?> getLastRead() async {
    Database db = await database.db;

    List<Map<String, dynamic>> dataLastRead = await db.query(
      "bookmark",
      where: "last_read = 1",
    );

    if (dataLastRead.isEmpty) {
      return null;
    } else {
      return dataLastRead.first;
    }
  }

  void deleteBookmark(int id) async {
    Database db = await database.db;

    db.delete("bookmark", where: "id = $id");

    update();
  }

  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database db = await database.db;

    List<Map<String, dynamic>> allBookmark = await db.query(
      "bookmark",
      where: "last_read = 0",
    );

    return allBookmark;
  }

  Future<List<Surah>> getAllSurahFuture() async {
    try {
      Uri url = Uri.parse("https://api.quran.gading.dev/surah");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List? data =
            (json.decode(response.body) as Map<String, dynamic>)["data"];
        if (data != null && data.isNotEmpty) {
          allSurah.value = data.map((e) => Surah.fromJson(e)).toList();
          return allSurah;
        } else {
          return [];
        }
      } else {
        // ignore: avoid_print
        print("Failed to load data: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error occurred: $e");
      return [];
    }
  }

  Future<List<Juz>> getAllJuzFuture() async {
    List<Juz> allJuz = [];
    for (var i = 1; i <= 30; i++) {
      try {
        Uri url = Uri.parse("https://api.quran.gading.dev/juz/$i");
        var response = await http.get(url);

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          var data = jsonResponse["data"];

          if (data != null) {
            allJuz.add(Juz(
              code: jsonResponse["code"],
              status: jsonResponse["status"],
              message: jsonResponse["message"],
              data: Data.fromJson(data),
            ));
          }
        } else {
          // ignore: avoid_print
          print("Failed to load data: ${response.statusCode}");
        }
      } catch (e) {
        // ignore: avoid_print
        print("Error occurred: $e");
      }
    }
    return allJuz;
  }
}
