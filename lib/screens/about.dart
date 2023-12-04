// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:attendance/widgets/nav_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange,
      appBar: AppBar(
        leadingWidth: size.width * 0.2,
        leading: Navigator.canPop(context) == false
            ? const SizedBox()
            : Row(
                children: [
                  NavButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    tooltip: "Back",
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 10, right: 0),
                  ),
                ],
              ),
        title: Text(
          "About",
          style: GoogleFonts.poppins(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Attendd v1.1.3 (stable)",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
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
                """Greetings! I'm Athar Mujtaba Wani, a dedicated developer specializing in the creation of dynamic mobile and web applications using Flutter and Django. Proficient in languages like C, C++, Python, Dart, and Rust, I bring a diverse skill set to the development landscape. If you're interested in collaboration or have a project in mind, feel free to get in touch.\nLet's work together to transform your concepts into exceptional digital experiences!""",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: size.width * 0.03,
                ),
              ),
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Theme.of(context).colorScheme.onInverseSurface,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if (await hasNetwork()) {
                        await launchUrl(
                            Uri.parse("mailto:atharwani001@gmail.com"));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(errorSnackBar());
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Image.asset("assets/images/email.png"),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (await hasNetwork()) {
                        launchUrl(Uri.parse(
                            "https://instagram.com/guy_with_glasses__"));
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/images/instagram.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (await hasNetwork()) {
                        await launchUrl(Uri.parse("https://atharwani.dev"));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(errorSnackBar());
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/images/web.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (await hasNetwork()) {
                        await launchUrl(Uri.parse(
                            "https:linkedin.com/in/athar-mujtaba-wani-ab0581216"));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(errorSnackBar());
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/images/linkedIn.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Text(
              "About the app",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                """Introducing Attendd, your academic companion dedicated to streamlining attendance tracking and providing insights into CIE marks at KLE Technological University. No more repetitive logins – simply enter your USN and DOB once, and Attendd takes care of the rest.
            
            Born out of a shared student experience, Attendd offers a user-friendly interface for quick access to attendance and subject-wise CIE marks. This unofficial side project aims to enhance your academic journey by eliminating unnecessary hassles.
            
            Please note that Attendd is an independent initiative and not the official app of KLE Technological University. Enjoy a smoother academic experience with Attendd – your reliable academic companion.""",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: size.width * 0.03,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
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
              margin: const EdgeInsets.only(top: 10),
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
                    ScaffoldMessenger.of(context).showSnackBar(errorSnackBar());
                  }
                },
                child: const Image(
                  image: AssetImage("assets/images/github.png"),
                  height: 40,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Text(
                "Found a bug? Report it here",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // blurred colour
                color: Colors.red,
              ),
              child: IconButton(
                onPressed: () async {
                  HapticFeedback.mediumImpact();
                  if (await launchUrl(
                    Uri.parse(
                        "mailto:atharwani001@gmail.com?subject=Bug Report&body=Hi Athar, I found a bug in your app."),
                  )) {
                  } else {
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

  SnackBar errorSnackBar() {
    return const SnackBar(
      content: Text("No Internet Connection"),
      backgroundColor: Colors.red,
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
