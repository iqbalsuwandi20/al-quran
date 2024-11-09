import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/juz.dart' as juz;
import '../../../data/models/surah.dart';
import '../controllers/detail_juz_screen_controller.dart';

class DetailJuzScreenView extends GetView<DetailJuzScreenController> {
  DetailJuzScreenView({super.key});

  final juz.Juz detailJuz = Get.arguments["juz"];
  final List<Surah> allSurahInThisJuz = Get.arguments["surah"];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFAF8FC),
      appBar: AppBar(
        title: Text(
          'JUZ ${detailJuz.data.juz}',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[700],
        elevation: 10,
        shadowColor: Colors.pink[200],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(width * 0.05),
        child: ListView.builder(
          itemCount: detailJuz.data.verses.length,
          itemBuilder: (context, index) {
            if (detailJuz.data.verses.isEmpty) {
              return Center(
                child: Text(
                  "Mohon maaf tidak ada data!",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              );
            }
            juz.Verse ayat = detailJuz.data.verses[index];
            if (index != 0 && ayat.number.inSurah == 1) {
              controller.index++;
            }

            return Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.01),
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink[100]!.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: width * 0.12,
                            width: width * 0.12,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/list.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${ayat.number.inSurah}",
                                style: GoogleFonts.poppins(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.05,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.05),
                          Text(
                            allSurahInThisJuz[controller.index]
                                .name
                                .transliteration
                                .id
                                .toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: width * 0.045,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_add_outlined,
                              color: Colors.pink[700],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.play_arrow_outlined,
                              color: Colors.pink[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.pink[200],
                    thickness: 1.5,
                    indent: width * 0.1,
                    endIndent: width * 0.1,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    ayat.text.arab,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: width * 0.10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    ayat.text.transliteration.en,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: width * 0.05,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    ayat.translation.id,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: width * 0.05,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    ayat.translation.en,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: width * 0.05,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
