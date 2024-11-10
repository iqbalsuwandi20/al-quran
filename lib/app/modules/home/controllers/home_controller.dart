import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/juz.dart';
import '../../../data/models/surah.dart';

class HomeController extends GetxController {
  var allSurah = <Surah>[].obs;

  Stream<List<Surah>> getAllSurahStream() async* {
    try {
      Uri url = Uri.parse("https://api.quran.gading.dev/surah");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List? data =
            (json.decode(response.body) as Map<String, dynamic>)["data"];
        if (data == null || data.isEmpty) {
          yield [];
        } else {
          allSurah.value = data.map((e) => Surah.fromJson(e)).toList();
          yield allSurah;
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
        yield [];
      }
    } catch (e) {
      print("Error occurred: $e");
      yield [];
    }
  }

  Stream<List<Juz>> getAllJuzStream() async* {
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
            yield allJuz;
          }
        } else {
          print("Failed to load data: ${response.statusCode}");
        }
      } catch (e) {
        print("Error occurred: $e");
      }
    }
  }
}
