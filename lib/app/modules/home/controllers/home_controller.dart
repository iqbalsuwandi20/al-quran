import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/juz.dart';
import '../../../data/models/surah.dart';

class HomeController extends GetxController {
  List<Surah> allSurah = [];

  Future<List<Surah>> getAllSurah() async {
    try {
      Uri url = Uri.parse("https://api.quran.gading.dev/surah");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List? data =
            (json.decode(response.body) as Map<String, dynamic>)["data"];
        if (data == null || data.isEmpty) {
          return [];
        } else {
          allSurah = data.map((e) => Surah.fromJson(e)).toList();
          return allSurah;
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

  Future<List<Juz>> getAllJuz() async {
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
