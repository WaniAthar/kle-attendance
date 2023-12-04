import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TileContainer extends StatelessWidget {
  TileContainer(
      {Key? key,
      this.colorGradient1 = const Color.fromARGB(255, 54, 155, 58),
      this.colorGradient2 = const Color.fromARGB(255, 115, 247, 120),
      required this.courseCode,
      required this.courseName,
      required this.cieMarks,
      required this.attendance})
      : super(key: key);
  Color colorGradient1, colorGradient2;
  final String courseCode, courseName, cieMarks, attendance;
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
    Size size = MediaQuery.of(context).size;
    checkAttendance(attendance);
    return Container(
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

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // textBaseline: TextBaseline.alphabetic,
            // crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                width: 200,
                child: Column(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      courseCode, //subject code
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2),
                    ),
                    Flex(
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
                  ],
                ),
              ),
              Column(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Flex(direction: Axis.horizontal, children: [
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        attendance,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  'CIE ',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Text(
                  cieMarks,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
