import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDev extends StatelessWidget {
  const AboutDev({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
          "About Developer",
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          tooltip: "Back",
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_sharp),
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.orange,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // image
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: size.width * 0.6,
              // cache image
              child: Image(
                image: const AssetImage("assets/images/athar.png"),
                height: size.height * 0.3,
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
              indent: 100,
              endIndent: 100,
            ),
            Text(
              "B.E. Computer Science",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
              indent: 100,
              endIndent: 100,
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Hi, I'm Athar Mujtaba Wani, a developer who is interested in open source and language semantics.",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: size.width * 0.03,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "\"I make softwares that work\"",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: size.width * 0.03,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Text(
              "Make a contribution",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: size.width * 0.03,
              ),
            ),

            Container(
              width: size.width * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  HapticFeedback.mediumImpact();
                  // if internet is not available
                  if (await hasNetwork()) {
                    await (launchUrl(Uri.parse(
                        "https://github.com/waniathar/kle-attendance.git")));
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No Internet Connection"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Image(
                  image: AssetImage("assets/images/github.png"),
                  height: 40,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Text(
              "Found a bug?",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // blurred colour
                color: Colors.red,
              ),
              child: IconButton(
                onPressed: () async {
                  HapticFeedback.mediumImpact();
                  if (await launchUrl(Uri.parse(
                      "mailto:atharwani001@gmail.com?subject=Bug Report&body=Hi Athar, I found a bug in your app."))) {
                    // snackbar
                    true;
                  } else {
                    // snackbar
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Couldn't launch mail app"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                tooltip: "Let's kill the bug",
                icon: const Icon(
                  Icons.bug_report_outlined,
                  color: Colors.white,
                  size: 30,
                  grade: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('github.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
