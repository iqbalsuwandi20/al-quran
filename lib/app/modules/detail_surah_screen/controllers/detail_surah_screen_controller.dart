import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/detail_surah.dart';

class DetailSurahScreenController extends GetxController {
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
}
