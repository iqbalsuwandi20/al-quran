import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/detail_surah.dart' as detail;
import '../../../data/models/surah.dart';
import '../controllers/detail_surah_screen_controller.dart';

class DetailSurahScreenView extends GetView<DetailSurahScreenController> {
  DetailSurahScreenView({super.key});

  final Surah surah = Get.arguments;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFAF8FC),
      appBar: AppBar(
        title: Text(
          'SURAH ${surah.name.transliteration.id.toUpperCase()}',
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
          icon: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Icon(
              Icons.arrow_back_ios_new,
              key: ValueKey<int>(1),
              color: Colors.white,
            ),
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => Get.defaultDialog(
                    title:
                        "TAFSIR ${surah.name.transliteration.id.toUpperCase()}",
                    titleStyle: GoogleFonts.poppins(
                      color: Colors.pink[700],
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.pink[50],
                    radius: 20,
                    content: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: height * 0.7,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          width: width * 0.9,
                          padding: EdgeInsets.all(width * 0.04),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.pink[50]!, Colors.white],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(width * 0.02),
                                child: Text(
                                  surah.tafsir.id,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black87,
                                    fontSize: width * 0.045,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.pink[200],
                                thickness: 1.5,
                                indent: width * 0.1,
                                endIndent: width * 0.1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.pink[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            surah.name.transliteration.id.toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: width * 0.08,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[800],
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            surah.name.translation.id.toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: width * 0.06,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            "${surah.numberOfVerses} Ayat | ${surah.revelation.id}",
                            style: GoogleFonts.poppins(
                              fontSize: width * 0.04,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            "Tekan untuk membaca tafsir",
                            style: GoogleFonts.poppins(
                              fontSize: width * 0.04,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              FutureBuilder<detail.DetailSurah>(
                future: controller.getDetailSurah(surah.number.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.pink[700],
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.data.verses.isEmpty) {
                    return const Center(
                      child: Text(
                        "Mohon maaf, tidak ada data yang tersedia!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }

                  var dataSurah = snapshot.data!.data;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dataSurah.verses.length,
                    itemBuilder: (context, index) {
                      detail.Verse verse = dataSurah.verses[index];
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(vertical: height * 0.01),
                        padding: EdgeInsets.all(width * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink[100]!.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: width * 0.12,
                                  width: width * 0.12,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/list.png"),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${verse.number.inSurah}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.05,
                                      ),
                                    ),
                                  ),
                                ),
                                GetBuilder<DetailSurahScreenController>(
                                  builder: (c) {
                                    return Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.bookmark_add_outlined,
                                            color: Colors.pink[700],
                                          ),
                                        ),
                                        (verse.audioCondition == "stop")
                                            ? IconButton(
                                                onPressed: () async {
                                                  c.playAudio(verse);
                                                },
                                                icon: Icon(
                                                  Icons.play_arrow_outlined,
                                                  color: Colors.pink[700],
                                                ),
                                              )
                                            : Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  (verse.audioCondition ==
                                                          "playing")
                                                      ? IconButton(
                                                          onPressed: () async {
                                                            c.pauseAudio(verse);
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .pause_outlined,
                                                            color: Colors
                                                                .pink[700],
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () async {
                                                            c.resumeAudio(
                                                                verse);
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .play_arrow_outlined,
                                                            color: Colors
                                                                .pink[700],
                                                          ),
                                                        ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      c.stopAudio(verse);
                                                    },
                                                    icon: Icon(
                                                      Icons.stop_outlined,
                                                      color: Colors.pink[700],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            Divider(
                              color: Colors.pink[200],
                              thickness: 1.5,
                              indent: width * 0.1,
                              endIndent: width * 0.1,
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              verse.text.arab,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: width * 0.10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              verse.text.transliteration.en,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.05,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              verse.translation.id,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.05,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
