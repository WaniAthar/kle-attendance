import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:attendance/api/attendance_api.dart';
import 'main.dart';

class InputData extends StatefulWidget {
  const InputData({super.key});

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  // for saving the data to the shared preferences
  String usn = "";
  String dd = "";
  String mm = "";
  String yyyy = "";
  String error = "";
  // for getting the data from the shared preferences
  String? usnFromSharedPref = "";
  String? ddFromSharedPref = "";
  String? mmFromSharedPref = "";
  String? yyyyFromSharedPref = "";
  String? errorGet;
  // function to get the data from the shared preferences

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<API>(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Login Details",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Privacy policy",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PrivacyPolicy(),
              ));
            },
            icon: const Icon(
              Icons.policy,
              size: 30,
              color: Colors.white,
            ),
          ),
          IconButton(
              tooltip: "Terms of service",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TOS(),
                ));
              },
              icon: const Icon(
                Icons.library_books_rounded,
                size: 30,
              ))
        ],
      ),
      body: Container(
        color: Colors.orange,
        width: double.infinity,
        height: double.infinity,
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 250,
                margin: const EdgeInsets.all(10),
                child: const LoadLottie(),
              ),
              SizedBox(
                width: deviceWidth * 0.8,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    filled: true,
                    hintText: "Enter your USN",
                    fillColor: Colors.white,
                    floatingLabelStyle: GoogleFonts.poppins(),
                    //  create rounded corners of the text field
                  ),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 15),
                  scrollPadding: const EdgeInsets.all(5),
                  cursorColor: Colors.black,
                  cursorWidth: 2,
                  // cursorRadius: Radius.circular(),
                  onChanged: (value) {
                    setState(
                      () {
                        usn = value.toUpperCase();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: deviceWidth * 0.27,
                      child: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50))),
                          filled: true,
                          hintText: "DD",
                          fillColor: Colors.white,
                          floatingLabelStyle: GoogleFonts.poppins(),
                          //  create rounded corners of the text field
                        ),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        scrollPadding: const EdgeInsets.all(5),
                        cursorColor: Colors.black,
                        cursorWidth: 2,
                        keyboardType: TextInputType.number,
                        // cursorRadius: Radius.circular(),
                        onChanged: (value) {
                          setState(
                            () {
                              dd = value;
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(width: deviceWidth * 0.01),
                    SizedBox(
                      width: deviceWidth * 0.23,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0)),
                          filled: true,
                          hintText: "MM",
                          fillColor: Colors.white,
                          floatingLabelStyle: GoogleFonts.poppins(),
                          //  create rounded corners of the text field
                        ),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        scrollPadding: const EdgeInsets.all(5),
                        cursorColor: Colors.black,
                        cursorWidth: 2,
                        keyboardType: TextInputType.number,
                        // cursorRadius: Radius.circular(),
                        onChanged: (value) {
                          setState(
                            () {
                              mm = value;
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(width: deviceWidth * 0.01),
                    SizedBox(
                      width: deviceWidth * 0.27,
                      child: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          filled: true,
                          hintText: "YYYY",
                          fillColor: Colors.white,
                          floatingLabelStyle: GoogleFonts.poppins(),
                          //  create rounded corners of the text field
                        ),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        scrollPadding: const EdgeInsets.all(5),
                        cursorColor: Colors.black,
                        cursorWidth: 2,
                        keyboardType: TextInputType.number,
                        // cursorRadius: Radius.circular(),
                        onChanged: (value) {
                          setState(
                            () {
                              yyyy = value;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                error,
                style: GoogleFonts.poppins(color: Colors.red, fontSize: 10),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (usn == "" || dd == "" || mm == "" || yyyy == "") {
                        setState(() {
                          error = "Please fill all the details";
                        });
                        return;
                      } else {
                        addDataToSharedPref();
                        api.isDataFetched = false;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: ((context) => const SLider())));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      animationDuration: const Duration(milliseconds: 1000),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: SizedBox(
                      height: deviceHeight * 0.06,
                      width: deviceWidth * 0.7,
                      child: Center(
                        child: Text(
                          "Submit",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "By clicking Submit you agree to our Terms of Service",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 10),
              ),
              Text(
                "and Privacy Policy",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 10),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ]),
      ),
    );
  }

  addDataToSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('usn', usn);
    prefs.setString('dd', dd);
    prefs.setString('mm', mm);
    prefs.setString('yyyy', yyyy);
  }

  getDataFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usnFromSharedPref = prefs.getString('usn');
    ddFromSharedPref = prefs.getString('dd');
    mmFromSharedPref = prefs.getString('mm');
    yyyyFromSharedPref = prefs.getString('yyyy');
  }

  // function to get the data from the shared preferences
}

// lottie animation loader class
class LoadLottie extends StatelessWidget {
  const LoadLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset(
          "assets/lottieanimations/117571-personal-animation.json"),
    );
  }
}

// ignore: must_be_immutable
class TOS extends StatelessWidget {
  TOS({super.key});
  String terms = """
Terms of Service for Attendd App:

Welcome to Attendd App! These Terms of Service ("Terms") govern your use of the Attend App ("the App"). The App is open source, which means that you can access and use the source code of the App for non-commercial purposes. However, the API used by the App is not open source and is proprietary.

By using the App, you agree to these Terms. If you do not agree to these Terms, you should not use the App.

Use of the App
You are granted a non-exclusive, non-transferable, revocable license to use the App solely for personal, non-commercial use in accordance with these Terms.

Ownership
The App and all of its components, including but not limited to the source code, design, graphics, and user interface, are owned by the developers of the App or its licensors and are protected by copyright, trademark, and other intellectual property laws.

Restrictions on Use
You agree that you will not:

Use the App for any illegal or unauthorized purpose;
Modify, adapt, translate, or reverse engineer the App;
Sell, rent, lease, or distribute the App;
Use the App in a way that infringes on the intellectual property rights of others;
Use the App to send spam or other unsolicited messages; or
Interfere with or disrupt the App or its servers.
API
The API used by the App is not open source and is proprietary. You may not access, use, or modify the API in any way without the express written permission of its owner.

Disclaimer of Warranties
The App is provided "as is" and without warranty of any kind. We make no representations or warranties of any kind, whether express, implied, statutory, or otherwise, regarding the App or its operation.

Limitation of Liability
We shall not be liable for any damages, including but not limited to direct, indirect, incidental, consequential, or punitive damages, arising out of or relating to the use of the App or its components.

Indemnification
You agree to indemnify, defend, and hold us harmless from any and all claims, damages, liabilities, costs, and expenses, including reasonable attorneys' fees, arising out of or relating to your use of the App or your breach of these Terms.

Changes to these Terms
We reserve the right to update or modify these Terms at any time without prior notice. Your continued use of the App after any such changes indicates your acceptance of the revised Terms.

Governing Law and Jurisdiction
These Terms shall be governed by and construed in accordance with the laws of the jurisdiction in which the developers of the App reside. Any legal action arising out of or relating to these Terms shall be brought exclusively in the courts of that jurisdiction.

Thank you for using Attendd App!

""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text("Terms of Service",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Text(terms,
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 15)),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});
  String policy = """
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text("Privacy Policy",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Text(policy,
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
