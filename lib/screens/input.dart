import 'package:attendance/screens/privacy.dart';
import 'package:attendance/screens/slider.dart';
import 'package:attendance/screens/terms.dart';
import 'package:attendance/widgets/nav_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:attendance/api/api_handler_provider.dart';

class InputData extends StatefulWidget {
  const InputData({super.key});

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  // for saving the data to the shared preferences

  String error = "";
  // for getting the data from the shared preferences
  String? usnFromSharedPref = "";
  String? ddFromSharedPref = "";
  String? mmFromSharedPref = "";
  String? yyyyFromSharedPref = "";
  String? errorGet;

  TextEditingController usn = TextEditingController();
  TextEditingController dd = TextEditingController();
  TextEditingController mm = TextEditingController();
  TextEditingController yyyy = TextEditingController();

  final usnFocus = FocusNode();
  final ddFocus = FocusNode();
  final mmFocus = FocusNode();
  final yyyyFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<API>(context, listen: false);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.orange,
      resizeToAvoidBottomInset: false,
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
        title: const Text(
          "Login",
        ),
        actions: [
          NavButton(
            tooltip: "Privacy policy",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicy(),
                ),
              );
            },
            icon: const Icon(
              Icons.policy,
              color: Colors.orange,
            ),
            margin: const EdgeInsets.only(right: 15),
          ),
          NavButton(
            tooltip: "Terms of Service",
            icon: const Icon(
              Icons.library_books_rounded,
              color: Colors.orange,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TOS(),
              ));
            },
            margin: const EdgeInsets.only(right: 10),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceHeight * 0.03,
            ),
            Container(
              width: deviceWidth * 0.7,
              margin: const EdgeInsets.all(10),
              child: const LoadLottie(),
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
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
                controller: usn,
                focusNode: usnFocus,
                onChanged: (value) {
                  if (value.length >= 12) {
                    usnFocus.nextFocus();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: deviceWidth * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: deviceWidth * 0.25,
                    child: TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
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
                      focusNode: ddFocus,
                      controller: dd,
                      onChanged: (value) {
                        if (value.length >= 2) {
                          ddFocus.nextFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.25,
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
                      focusNode: mmFocus,
                      controller: mm,
                      onChanged: (value) {
                        if (value.length >= 2) {
                          mmFocus.nextFocus();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.25,
                    child: TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
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
                      focusNode: yyyyFocus,
                      controller: yyyy,
                      onChanged: (value) {
                        if (value.length >= 4) {
                          yyyyFocus.unfocus();
                        }
                      },
                    ),
                  ),
                ],
              ),
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
                    if (usn.text == "" ||
                        dd.text == "" ||
                        mm.text == "" ||
                        yyyy.text == "") {
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: SizedBox(
                    height: deviceHeight * 0.06,
                    width: deviceWidth * 0.7,
                    child: Center(
                      child: Text(
                        "Submit",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
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
      ),
    );
  }

  addDataToSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('usn', usn.text.toUpperCase());
    prefs.setString('dd', dd.text.toUpperCase());
    prefs.setString('mm', mm.text.toUpperCase());
    prefs.setString('yyyy', yyyy.text.toUpperCase());
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
      child: Lottie.asset("assets/lottieanimations/person.json"),
    );
  }
}
