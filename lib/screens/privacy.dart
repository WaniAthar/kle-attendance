import 'package:attendance/widgets/nav_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});
  final String policy = """
Privacy Policy for Attendd App:

Thank you for using Attendd App ("the App"). This privacy policy explains how we collect, use, and protect your personal information when you use our App. By using our App, you agree to the terms and conditions of this policy.

Information We Collect:
We only collect two pieces of information from the user- USN and date of birth, which is used to fetch the attendance data from the server. We do not collect any other personal information from the users.

How We Use Your Information:
We only use the collected information to fetch the attendance data from the server. We do not share, sell, or rent your personal information to any third-party.

Data Storage:
All the data that the App collects is stored locally on the user's device, and we do not transmit any data to our servers or any third-party servers. We take all the necessary measures to ensure that your data is safe and secure.

No Ads:
We do not show any ads on the App, and we do not use any third-party advertising networks.

Contact Us:
If you have any questions or concerns about our privacy policy or our App, please contact us at atharwani001@gmail.com.

Changes to this Policy:
We reserve the right to update or modify this privacy policy at any time. We will post any changes on this page, and we encourage you to review this policy periodically.

Thank you for using Attendd App!
""";
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange,
      appBar: AppBar(
        leadingWidth: deviceWidth * 0.2,
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
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Text(policy,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
