import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/surah.dart';

class HomeController extends GetxController {
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
          return data.map((e) => Surah.fromJson(e)).toList();
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
}
