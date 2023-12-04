import 'package:attendance/api/api_handler_provider.dart';
import 'package:attendance/screens/homepage.dart';
import 'package:attendance/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SLider extends StatefulWidget {
  const SLider({super.key});
  @override
  State<SLider> createState() => _SLiderState();
}

class _SLiderState extends State<SLider> {
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    final api = Provider.of<API>(context);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        backdropTapClosesPanel: true,
        body: const HomePage(),
        minHeight: deviceHeight * 0.5,
        maxHeight: deviceHeight * 0.89,
        backdropEnabled: true,
        backdropOpacity: 0,
        color: Colors.transparent,
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
          )
        ],
        panel: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 10,
                width: 80,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(115, 45, 44, 44),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // shimmer effect for the 'semester' text
              FutureBuilder(
                future: api.getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    isLoaded = true;
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Semester 7",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ));
                  } else {
                    return Text(
                      api.attendanceData == null
                          ? ""
                          : '${api.personalData['semester']}', //semester
                      style: GoogleFonts.poppins(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    );
                  }
                },
              ),

              isLoaded == false
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: deviceWidth * 0.3,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 180, 61, 61),
                                Color.fromARGB(255, 255, 89, 89)
                              ])),
                          child: Text(
                            "Below 65%",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: deviceWidth * 0.03),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: deviceWidth * 0.3,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 237, 216, 82),
                            Color.fromARGB(255, 180, 166, 61)
                          ])),
                          child: Text(
                            "65% to 75%",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: deviceWidth * 0.03),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: deviceWidth * 0.3,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 54, 155, 58),
                                Color.fromARGB(255, 115, 247, 120)
                              ])),
                          child: Text(
                            "Above 75%",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: deviceWidth * 0.03),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: deviceWidth * 0.02,
              ),

              Flexible(
                child: FutureBuilder<void>(
                  // future: api.getAttendanceData(),
                  future: api.getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // show shimmer effect while waiting for data
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? 6
                              : api.attendanceData.length,
                          itemBuilder: (_, __) => TileContainer(
                            // dummy data //
                            attendance: "90%",
                            courseCode: "18CSL67dd",
                            courseName: "Machine Learning",
                            cieMarks: "100/100",
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // show error message if there is an error
                      return Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LottieBuilder.asset(
                                "assets/lottieanimations/no_internet.json"),
                            const SizedBox(height: 30),
                            Text(
                                'Please check your internet connection and try again',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                textAlign: TextAlign.center),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                                "If the problem persists, please check your USN and DOB and try again",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                textAlign: TextAlign.center),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Click the ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                    textAlign: TextAlign.center),
                                const Icon(
                                  Icons.person,
                                  color: Colors.red,
                                ),
                                Text(" icon to change your USN and/or DOB",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // show data in a list
                      final data = api.attendanceData;
                      return ListView.builder(
                        shrinkWrap: true,
                        padding:
                            EdgeInsets.only(bottom: deviceWidth * 0.05, top: 0),
                        itemCount: data.length ?? 6,
                        itemBuilder: (context, index) => TileContainer(
                          courseCode: data[index]['course_code'],
                          courseName: data[index]['course_name'],
                          cieMarks: data[index]['cie_marks'],
                          attendance: data[index]['course_attendance'],
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LottieBuilder.asset(
                                "assets/lottieanimations/no_internet.json"),
                            const SizedBox(height: 30),
                            Text(
                                'Please check your internet connection and try again',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                textAlign: TextAlign.center),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                                "If the problem persists, please check your USN and DOB and try again",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                textAlign: TextAlign.center),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Click the ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                    textAlign: TextAlign.center),
                                const Icon(
                                  Icons.person,
                                  color: Colors.red,
                                ),
                                Text(" icon to change your USN and/or DOB",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                            Text(
                                "If the problem still persists then the http://student.kletech.ac.in website is down, you can try this url in your browser to check",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
