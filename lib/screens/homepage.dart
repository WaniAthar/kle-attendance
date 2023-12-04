import 'dart:developer';
import 'package:attendance/screens/about.dart';
import 'package:attendance/screens/coe.dart';
import 'package:attendance/screens/input.dart';
import 'package:attendance/screens/slider.dart';
import 'package:attendance/widgets/nav_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:attendance/api/api_handler_provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final api = Provider.of<API>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: deviceWidth * 0.2,
        title: const Text(
          "Attendd",
        ),
        leading: Row(
          children: [
            NavButton(
              tooltip: "About the app",
              icon: const Icon(
                Icons.info,
                color: Colors.orange,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const About()));
              },
              margin: const EdgeInsets.only(left: 10, right: 10),
            ),
          ],
        ),
        actions: [
          NavButton(
            tooltip: "refresh",
            icon: const Icon(
              Icons.refresh,
              color: Colors.orange,
            ),
            onPressed: () {
              api.isDataFetched = false;
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) => const SLider(),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
          NavButton(
            tooltip: "Edit USN",
            icon: const Icon(
              Icons.person,
              color: Colors.orange,
            ),
            onPressed: () async {
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const InputData()));
            },
            margin: const EdgeInsets.only(right: 10, left: 10),
          ),
        ],
      ),
      backgroundColor: Colors.orange,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          FutureBuilder(
            // dont call the api.getData() here, it will call the api everytime the build method is called
            // instead call it in the init state of the provider
            // future: api.getPersonalData(),
            future: api.getData(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildShimmerEffect(size);
              } else if (snapshot.hasError) {
                api.fetchErr = true;
                return Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                      width: double.infinity,
                      child: Lottie.asset("assets/lottieanimations/error.json"),
                    ),
                    Text("Internet error :(",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                );
              } else if (snapshot.hasData) {
                return _buildData(api, size);
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                      width: double.infinity,
                      child: Lottie.asset("assets/lottieanimations/error.json"),
                    ),
                    Text("Internet error :(",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                );
              }
            },
          ),
          Positioned(
            top: size.height * 0.01,
            left: size.width * 0.03,
            child: FutureBuilder(
              future: api.getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildCreditsShimmer(size);
                } else if (snapshot.hasError) {
                  log("Error:  ${snapshot.error}");
                  return const SizedBox();
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Credits Earned : ",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            "${api.personalData['credits_earned'] ?? ''}",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        child: Row(
                          children: [
                            Text(
                              "Credits to Earn : ",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              "${api.personalData['credits_to_earn'] ?? ''}",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          Positioned(
            top: 30,
            right: 0,
            child: SizedBox(
              height: 50,
              width: size.width * 0.15,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const COE(),
                    ),
                  );
                },
                tooltip: "Calender of Events",
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(20)),
                ),
                child: Shimmer.fromColors(
                    baseColor: Colors.orange,
                    highlightColor: Colors.white,
                    child: const Icon(
                      Icons.calendar_month,
                      color: Colors.orange,
                    )),
              ),
            ),
          ),
          Positioned(
            top: (size.height - 60) * 0.39,
            right: 0,
            left: 0,
            child: Shimmer.fromColors(
              period: const Duration(milliseconds: 2000),
              baseColor: Colors.orange,
              highlightColor: Colors.white,
              child: Container(
                margin: const EdgeInsets.all(1),
                child: Text(
                  "Slide up",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names

  Widget _buildShimmerEffect(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.white30,
      highlightColor: Colors.white,
      child: Container(
        height: size.height / 2 - 1,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              height: size.height * 0.2,
              child: Lottie.asset("assets/lottieanimations/cycling.json"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 25,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 20,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildData(API api, Size size) {
    return Container(
      height: size.height * 0.5 - 50,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: size.height * 0.24,
            child: Lottie.asset("assets/lottieanimations/cycling.json"),
          ),
          Text('${api.personalData['name']}',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: size.height * 0.026,
                fontWeight: FontWeight.bold,
              )),
          const Divider(
            color: Colors.white,
            thickness: 1,
            indent: 100,
            endIndent: 100,
          ),
          Text(
            '${api.personalData['usn']}',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: size.height * 0.016,
              fontWeight: FontWeight.w400,
              letterSpacing: 2,
            ),
          )
        ],
      ),
    );
  }

//Shimmer effect for the credits position
  Widget _buildCreditsShimmer(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.white30,
      highlightColor: Colors.white,
      child: Column(
        children: [
          Container(
            height: 20,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 20,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}
