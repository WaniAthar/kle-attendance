// ignore_for_file: sort_child_properties_last
import 'package:attendance/scrapping/scrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'homepage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'input.dart';
import 'developer.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      home: const FirstScreen(),
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
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const InputData())));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.orange,
      child: Center(
        child: Text("Loading...🥶",
            style: GoogleFonts.poppins(fontSize: 30, color: Colors.white)),
      ),
    );
  }
}

class TileContainer extends StatelessWidget {
  const TileContainer(
      {Key? key,
      this.colorGradient1 = const Color.fromARGB(255, 101, 210, 105),
      this.colorGradient2 = const Color.fromARGB(255, 105, 249, 110)})
      : super(key: key);
  final Color colorGradient1, colorGradient2;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "20ECSC203", //subject code
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Expanded(
                    child: Text(
                      "Computer Networks-2", //subject name
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "VIJAYALAXMI M", //professor name
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  "89%",
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
              Scrapper();
            },
            icon: const Icon(Icons.refresh_rounded,
                color: Colors.white, size: 30),
          ),
          IconButton(
            hoverColor: Colors.white,
            splashColor: Colors.white30,
            tooltip: "Edit USN",
            onPressed: () {
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
              Text(
                "Semester 6", //semester
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView(
                  children: const [
                    TileContainer(),
                    TileContainer(
                      colorGradient1: Color.fromARGB(255, 246, 105, 95),
                      colorGradient2: Color.fromARGB(255, 253, 145, 137),
                    ),
                    TileContainer(),
                    TileContainer(
                      colorGradient1: Color.fromARGB(255, 246, 105, 95),
                      colorGradient2: Color.fromARGB(255, 253, 145, 137),
                    ),
                    TileContainer(),
                    TileContainer(),
                    TileContainer(
                      colorGradient1: Color.fromARGB(255, 246, 105, 95),
                      colorGradient2: Color.fromARGB(255, 253, 145, 137),
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
