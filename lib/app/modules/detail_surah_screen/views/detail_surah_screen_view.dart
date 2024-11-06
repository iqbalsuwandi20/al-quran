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

    return Scaffold(
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.pink[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
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
                        const SizedBox(height: 10),
                        Text(
                          "( ${surah.name.translation.id.toUpperCase()} )",
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.06,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "${surah.numberOfVerses} Ayat | ${surah.revelation.id}",
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
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
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(15),
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
                                CircleAvatar(
                                  backgroundColor: Colors.pink[100],
                                  child: Text(
                                    "${verse.number.inSurah}",
                                    style: TextStyle(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.06,
                                    ),
                                  ),
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
                            const SizedBox(height: 10),
                            Text(
                              verse.text.arab,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: width * 0.10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              verse.text.transliteration.en,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: width * 0.05,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              verse.translation.id,
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
