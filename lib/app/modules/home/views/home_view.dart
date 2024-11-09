import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/juz.dart' as juz;
import '../../../data/models/surah.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFAF8FC),
      appBar: AppBar(
        title: Text(
          'AL-QUR\'AN',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[700],
        elevation: 8,
        actions: [
          IconButton(
            onPressed: () {
              Routes.SEARCH_SCREEN;
            },
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Icon(
                Icons.search_outlined,
                key: ValueKey<int>(1),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06, vertical: screenHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamu'alaikum",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[700],
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.LAST_READ_SCREEN),
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Colors.pink[200]!, Colors.pink[400]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: -5,
                        right: 0,
                        child: Opacity(
                          opacity: 0.7,
                          child: Image.asset(
                            "assets/images/quran.png",
                            width: screenWidth * 0.25,
                            height: screenWidth * 0.25,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.menu_book_outlined,
                                  color: Colors.white),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                "Terakhir dibaca",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.04),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            "Al-Fatihah",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Juz 1 | Ayat 5",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: screenWidth * 0.04),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              TabBar(
                indicatorColor: Colors.pink[700],
                labelColor: Colors.pink[700],
                unselectedLabelColor: Colors.grey,
                labelStyle: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.w600),
                tabs: [
                  Tab(text: "Surah"),
                  Tab(text: "Juz"),
                  Tab(text: "Penanda"),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                  color: Colors.pink[700]));
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Terjadi kesalahan: ${snapshot.error}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.045,
                              ),
                            ),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "Mohon maaf tidak ada data!",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.045,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Surah surah = snapshot.data![index];
                            return GestureDetector(
                              onTap: () => Get.toNamed(
                                  Routes.DETAIL_SURAH_SCREEN,
                                  arguments: surah),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.015),
                                padding: EdgeInsets.all(screenWidth * 0.04),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pink[200]!,
                                      Colors.pink[400]!
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.pink.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: screenWidth * 0.15,
                                      height: screenWidth * 0.15,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/list.png"),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${surah.number}",
                                          style: GoogleFonts.poppins(
                                            color: Colors.pink[700],
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth * 0.045,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.04),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            surah.name.transliteration.id,
                                            style: GoogleFonts.poppins(
                                              fontSize: screenWidth * 0.055,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(
                                              height: screenHeight * 0.005),
                                          Text(
                                            "${surah.numberOfVerses} Ayat | ${surah.revelation.id}",
                                            style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize: screenWidth * 0.04,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      surah.name.short,
                                      style: GoogleFonts.amiri(
                                        fontSize: screenWidth * 0.05,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    FutureBuilder<List<juz.Juz>>(
                      future: controller.getAllJuz(),
                      builder: (context, snapshot) {
                        final double screenWidth =
                            MediaQuery.of(context).size.width;
                        final double screenHeight =
                            MediaQuery.of(context).size.height;

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                                color: Colors.pink[700]),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Terjadi kesalahan: ${snapshot.error}",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.045,
                              ),
                            ),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "Mohon maaf tidak ada data!",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.045,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            juz.Juz detailJuz = snapshot.data![index];

                            String startName =
                                detailJuz.data.juzStartInfo.split(" - ").first;
                            String endName =
                                detailJuz.data.juzEndInfo.split(" - ").first;

                            List<Surah> allSurahInJuz = [];
                            List<Surah> rawAllSurahInJuz = [];

                            for (var item in controller.allSurah) {
                              rawAllSurahInJuz.add(item);
                              if (item.name.transliteration.id == endName) {
                                break;
                              }
                            }

                            for (var item
                                in rawAllSurahInJuz.reversed.toList()) {
                              allSurahInJuz.add(item);
                              if (item.name.transliteration.id == startName) {
                                break;
                              }
                            }

                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.DETAIL_JUZ_SCREEN,
                                  arguments: {
                                    "juz": detailJuz,
                                    "surah": allSurahInJuz.reversed.toList(),
                                  },
                                );
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.015),
                                padding: EdgeInsets.all(screenWidth * 0.04),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pink[200]!,
                                      Colors.pink[400]!,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.pink.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: screenWidth * 0.15,
                                      height: screenWidth * 0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/list.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: GoogleFonts.poppins(
                                            color: Colors.pink[700],
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth * 0.08,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.04),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Juz ${index + 1}",
                                            style: GoogleFonts.poppins(
                                              fontSize: screenWidth * 0.06,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: screenHeight * 0.01),
                                          Text(
                                            "Awal surat: ${detailJuz.data.juzStartInfo}",
                                            style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize: screenWidth * 0.04,
                                            ),
                                          ),
                                          SizedBox(height: screenHeight * 0.01),
                                          Text(
                                            "Akhir surat: ${detailJuz.data.juzEndInfo}",
                                            style: GoogleFonts.poppins(
                                              fontSize: screenWidth * 0.04,
                                              color: Colors.grey[900],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: screenWidth * 0.05,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Center(child: Text("Penanda Section")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
