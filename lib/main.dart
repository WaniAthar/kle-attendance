// ignore_for_file: sort_child_properties_last, use_build_context_synchronously
import 'package:attendance/api/attendance_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:shimmer/shimmer.dart';
import 'homepage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'input.dart';
import 'developer.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => API(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Attendance',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        home: const FirstScreen(),
        // home: const FirstScreen(),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with AfterLayoutMixin<FirstScreen> {
  Future checkFirstSeen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool firstScreenSeen_ = (pref.getBool('firstScreenSeen') ?? false);
    // firstScreenSeen_ = true;
    if (firstScreenSeen_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SLider()));
    } else {
      await pref.setBool('firstScreenSeen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const InputData())));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) =>
      Future.delayed(const Duration(seconds: 3), () => checkFirstSeen());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: Lottie.asset(
                "assets/lottieanimations/137650-geometric-figures-loading-animation.json"),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TileContainer extends StatelessWidget {
  TileContainer(
      {Key? key,
      this.colorGradient1 = const Color.fromARGB(255, 54, 155, 58),
      this.colorGradient2 = const Color.fromARGB(255, 115, 247, 120),
      required this.courseCode,
      required this.courseName,
      required this.professorName,
      required this.attendance})
      : super(key: key);
  Color colorGradient1, colorGradient2;
  final String courseCode, courseName, professorName, attendance;
  void checkAttendance(String att) {
    int per = int.parse(attendance.replaceAll("%", ""));
    if (per < 65) {
      colorGradient1 = const Color.fromARGB(255, 180, 61, 61);
      colorGradient2 = const Color.fromARGB(255, 255, 89, 89);
    } else if (per >= 65 && per <= 75) {
      colorGradient1 = const Color.fromARGB(255, 237, 216, 82);
      colorGradient2 = const Color.fromARGB(255, 180, 166, 61);
    }
  }

  @override
  Widget build(BuildContext context) {
    // calling checkAttendance fucntion to change colour of the container as per attendance
    checkAttendance(attendance);
    return Container(
      child: Row(
        children: [
          Flexible(
            child: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      courseCode, //subject code
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                          child: Text(
                            courseName, //subject name
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      professorName, //professor name
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  attendance,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.poppins(
                    fontSize: 58,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      // need to remove this line(use padding to auto resize the container)
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorGradient1, colorGradient2],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    );
  }
}

class SLider extends StatefulWidget {
  const SLider({super.key});

  @override
  State<SLider> createState() => _SLiderState();
}

class _SLiderState extends State<SLider> {
  @override
  Widget build(BuildContext context) {
    final api = Provider.of<API>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Attendance",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          hoverColor: Colors.white,
          splashColor: Colors.white30,
          tooltip: "About the Developer",
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutDev()));
          },
          icon: const Icon(
            Icons.adb,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            hoverColor: Colors.white,
            splashColor: Colors.white30,
            tooltip: "Refresh",
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
            icon: const Icon(Icons.refresh_rounded,
                color: Colors.white, size: 30),
          ),
          IconButton(
            hoverColor: Colors.white,
            splashColor: Colors.white30,
            tooltip: "Edit USN",
            onPressed: () {
              const HomePage();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const InputData()));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
            focusColor: Colors.orange,
          )
        ],
      ),
      body: SlidingUpPanel(
        body: const HomePage(),
        minHeight: 480,
        maxHeight: 750,
        backdropEnabled: true,
        backdropOpacity: 1,
        backdropColor: Colors.orange,
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
                margin: const EdgeInsets.all(10),
                height: 6,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // shimmer effect for the 'semester' text
              FutureBuilder(
                future: api.getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                        child: Container(
                          child: const Text(
                            "Semester 6",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!);
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

              Flexible(
                child: FutureBuilder<void>(
                  future: api.getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // show shimmer effect while waiting for data
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListView.builder(
                          itemCount: snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? 6
                              : api.attendanceData.length,
                          itemBuilder: (_, __) => TileContainer(
                            // dummy data //
                            attendance: "90%",
                            courseCode: "18CSL67dd",
                            courseName: "Machine Learning",
                            professorName: "Dr. S. S. Patil",
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
                    } else {
                      // show data in a list
                      final data = api.attendanceData;
                      return ListView.builder(
                        itemCount: data.length ?? 6,
                        itemBuilder: (context, index) => TileContainer(
                          courseCode: data[index]['course_code'],
                          courseName: data[index]['course_name'],
                          professorName: data[index]['course_teacher'],
                          attendance: data[index]['course_attendance'],
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
