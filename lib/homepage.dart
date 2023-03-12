import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'scrapping/scrapper.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //check data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              height: 200,
              child: const Image(
                image: AssetImage('assets/images/person.png'),
              ),
            ),
            Text(
              "ATHAR WANI",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
              indent: 100,
              endIndent: 100,
            ),
            Text(
              "01FE20BCS054",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
