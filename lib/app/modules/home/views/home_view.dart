import 'package:animated_text_kit/animated_text_kit.dart';
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
              Get.toNamed(Routes.SEARCH_SCREEN);
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
              Obx(
                () {
                  return GestureDetector(
                    onTap: () async {
                      if (controller.isLoading.isFalse) {
                        controller.isLoading.value = true;

                        await Future.delayed(Duration(milliseconds: 500));

                        Get.toNamed(Routes.LAST_READ_SCREEN);

                        controller.isLoading.value = false;
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: controller.isLoading.isFalse
                            ? LinearGradient(
                                colors: [Colors.pink[200]!, Colors.pink[400]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.grey[300]!,
                                  Colors.grey[500]!,
                                ],
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
                                    "Tekan terakhir dibaca",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.03),
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
                  );
                },
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
                      future: controller.getAllSurahFuture(),
                      builder: (context, snapshot) {
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
                            Surah surah = snapshot.data![index];
                            return Obx(
                              () {
                                return GestureDetector(
                                  onTap: () async {
                                    if (controller.isLoading.isFalse) {
                                      controller.selectedIndex.value = index;
                                      controller.isLoading.value = true;

                                      await Future.delayed(
                                          Duration(seconds: 5));

                                      await Get.toNamed(
                                          Routes.DETAIL_SURAH_SCREEN,
                                          arguments: surah);

                                      controller.isLoading.value = false;
                                      controller.selectedIndex.value = null;
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    margin: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.015),
                                    padding: EdgeInsets.all(screenWidth * 0.04),
                                    decoration: BoxDecoration(
                                      gradient: controller.isLoading.isFalse
                                          ? LinearGradient(
                                              colors: [
                                                Colors.pink[200]!,
                                                Colors.pink[400]!
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                          : LinearGradient(
                                              colors: [
                                                Colors.grey[300]!,
                                                Colors.grey[500]!,
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
                                    child: controller.isLoading.isFalse
                                        ? Row(
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          screenWidth * 0.045,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.04),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      surah.name.transliteration
                                                          .id,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize:
                                                            screenWidth * 0.055,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenHeight *
                                                            0.005),
                                                    Text(
                                                      "${surah.numberOfVerses} Ayat | ${surah.revelation.id}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.grey[900],
                                                        fontSize:
                                                            screenWidth * 0.04,
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
                                          )
                                        : Center(
                                            child: controller
                                                        .selectedIndex.value ==
                                                    index
                                                ? AnimatedTextKit(
                                                    animatedTexts: [
                                                      TyperAnimatedText(
                                                        'Tunggu...',
                                                        textStyle:
                                                            GoogleFonts.poppins(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.055,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black87,
                                                        ),
                                                        speed: Duration(
                                                            milliseconds: 200),
                                                      ),
                                                    ],
                                                    totalRepeatCount: 2,
                                                  )
                                                : Text(""),
                                          ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    FutureBuilder<List<juz.Juz>>(
                      future: controller.getAllJuzFuture(),
                      builder: (context, snapshot) {
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

                            return Obx(
                              () {
                                return GestureDetector(
                                  onTap: () async {
                                    if (controller.isLoading.isFalse) {
                                      controller.selectedIndex.value = index;
                                      controller.isLoading.value = true;

                                      await Future.delayed(
                                          Duration(seconds: 5));

                                      await Get.toNamed(
                                        Routes.DETAIL_JUZ_SCREEN,
                                        arguments: {
                                          "juz": detailJuz,
                                          "surah":
                                              allSurahInJuz.reversed.toList(),
                                        },
                                      );

                                      controller.isLoading.value = false;
                                      controller.selectedIndex.value = null;
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    margin: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.015),
                                    padding: EdgeInsets.all(screenWidth * 0.04),
                                    decoration: BoxDecoration(
                                      gradient: controller.isLoading.isFalse
                                          ? LinearGradient(
                                              colors: [
                                                Colors.pink[200]!,
                                                Colors.pink[400]!
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                          : LinearGradient(
                                              colors: [
                                                Colors.grey[300]!,
                                                Colors.grey[500]!,
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
                                    child: controller.isLoading.isFalse
                                        ? Row(
                                            children: [
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                width: screenWidth * 0.15,
                                                height: screenWidth * 0.15,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          screenWidth * 0.045,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.04),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Juz ${index + 1}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize:
                                                            screenWidth * 0.055,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenHeight *
                                                            0.005),
                                                    Text(
                                                      "Awal: ${detailJuz.data.juzStartInfo.replaceAll('-', '')}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.grey[900],
                                                        fontSize:
                                                            screenWidth * 0.04,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenHeight *
                                                            0.005),
                                                    Text(
                                                      "Akhir: ${detailJuz.data.juzEndInfo.replaceAll('-', '')}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.grey[900],
                                                        fontSize:
                                                            screenWidth * 0.04,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: screenHeight *
                                                            0.005),
                                                    Text(
                                                      "Total ayat: ${detailJuz.data.totalVerses}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.grey[900],
                                                        fontSize:
                                                            screenWidth * 0.04,
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
                                          )
                                        : Center(
                                            child: controller
                                                        .selectedIndex.value ==
                                                    index
                                                ? AnimatedTextKit(
                                                    animatedTexts: [
                                                      TyperAnimatedText(
                                                        'Tunggu...',
                                                        textStyle:
                                                            GoogleFonts.poppins(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.055,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black87,
                                                        ),
                                                        speed: Duration(
                                                            milliseconds: 200),
                                                      ),
                                                    ],
                                                    totalRepeatCount: 3,
                                                  )
                                                : Text(""),
                                          ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    GetBuilder<HomeController>(
                      builder: (c) {
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: c.getBookmark(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: Colors.pink[700]),
                              );
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  "Tidak ada yang disimpan",
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
                                Map<String, dynamic> data =
                                    snapshot.data![index];
                                return Obx(
                                  () {
                                    return GestureDetector(
                                      onTap: () async {
                                        if (c.isLoading.isFalse) {
                                          c.selectedIndex.value = index;
                                          c.isLoading.value = true;

                                          await Future.delayed(
                                              Duration(seconds: 5));

                                          c.isLoading.value = false;
                                          c.selectedIndex.value = null;
                                        }
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        margin: EdgeInsets.symmetric(
                                            vertical: screenHeight * 0.015),
                                        padding:
                                            EdgeInsets.all(screenWidth * 0.04),
                                        decoration: BoxDecoration(
                                          gradient: c.isLoading.isFalse
                                              ? LinearGradient(
                                                  colors: [
                                                    Colors.pink[200]!,
                                                    Colors.pink[400]!,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                )
                                              : LinearGradient(
                                                  colors: [
                                                    Colors.grey[300]!,
                                                    Colors.grey[500]!,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.pink.withOpacity(0.2),
                                              blurRadius: 8,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: c.isLoading.isFalse
                                            ? Row(
                                                children: [
                                                  AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    width: screenWidth * 0.15,
                                                    height: screenWidth * 0.15,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/list.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "${index + 1}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Colors.pink[700],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              screenWidth *
                                                                  0.045,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          screenWidth * 0.04),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data["surah"]
                                                              .toString()
                                                              .replaceAll(
                                                                  "+", "'"),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize:
                                                                screenWidth *
                                                                    0.055,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.005),
                                                        Text(
                                                          "Ayat ${data["ayat"]}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors
                                                                .grey[900],
                                                            fontSize:
                                                                screenWidth *
                                                                    0.04,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.005),
                                                        Text(
                                                          "Via ${data["surah"].toString().replaceAll("+", "'")}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors
                                                                .grey[900],
                                                            fontSize:
                                                                screenWidth *
                                                                    0.04,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      c.deleteBookmark(
                                                          data["id"]);
                                                    },
                                                    icon: Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )
                                            : Center(
                                                child: c.selectedIndex.value ==
                                                        index
                                                    ? AnimatedTextKit(
                                                        animatedTexts: [
                                                          TyperAnimatedText(
                                                            'Tunggu...',
                                                            textStyle:
                                                                GoogleFonts
                                                                    .poppins(
                                                              fontSize:
                                                                  screenWidth *
                                                                      0.055,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                            speed: Duration(
                                                                milliseconds:
                                                                    200),
                                                          ),
                                                        ],
                                                        totalRepeatCount: 2,
                                                      )
                                                    : Text(""),
                                              ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
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
