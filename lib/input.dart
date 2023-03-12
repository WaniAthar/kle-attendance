import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      ),
      body: Container(
        color: Colors.orange,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              margin: const EdgeInsets.all(10),
              child: const Image(image: AssetImage("assets/images/old.png")),
            ),
            SizedBox(
              width: 310,
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
                cursorWidth: 10,
                // cursorRadius: Radius.circular(),
                onChanged: (value) {
                  setState(
                    () {
                      usn = value.toUpperCase();
                      print(usn);
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
                    width: 100,
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
                      cursorWidth: 10,
                      keyboardType: TextInputType.number,
                      // cursorRadius: Radius.circular(),
                      onChanged: (value) {
                        setState(
                          () {
                            dd = value;
                            print(dd);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
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
                      cursorWidth: 10,
                      keyboardType: TextInputType.number,
                      // cursorRadius: Radius.circular(),
                      onChanged: (value) {
                        setState(
                          () {
                            mm = value;
                            print(mm);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
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
                      cursorWidth: 10,
                      keyboardType: TextInputType.number,
                      // cursorRadius: Radius.circular(),
                      onChanged: (value) {
                        setState(
                          () {
                            yyyy = value;
                            print(yyyy);
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => const SLider())));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: SizedBox(
                    height: 50,
                    width: 275,
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
