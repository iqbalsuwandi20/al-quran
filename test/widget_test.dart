import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  var response = await http.get(url);

  List data = (json.decode(response.body) as Map<String, dynamic>)["data"];

  Surah surahAnnas = Surah.fromJson(data[113]);

  // ignore: avoid_print
  print(surahAnnas.toJson());

  Uri urlAnnas =
      Uri.parse("https://api.quran.gading.dev/surah/${surahAnnas.number}");
  var responseAnnas = await http.get(urlAnnas);

  Map<String, dynamic> dataAnnas =
      (json.decode(responseAnnas.body) as Map<String, dynamic>)["data"];

  DetailSurah annas = DetailSurah.fromJson(dataAnnas);

  // ignore: avoid_print
  print(annas.data.verses);
}
