import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:attendance/api/attendance_api.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<API>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.orange,
            child: FutureBuilder(
              // dont call the api.getData() here, it will call the api everytime the build method is called
              // instead call it in the init state of the provider
              // future: api.getPersonalData(),
              future: api.getData(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildShimmerEffect(size);
                } else if (snapshot.hasError) {
                  api.fetchErr = true;
                  return Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                        width: double.infinity,
                        child: Lottie.asset(
                            "assets/lottieanimations/91950-loop-loading-animation.json"),
                      ),
                      Text("Internet error :(",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ],
                  );
                } else {
                  return _buildData(api, size);
                }
              },
            ),
          ),
          Positioned(
            top: size.height * 0.01,
            right: size.width * 0.03,
            child: Text(
              "v1.1.2+5",
              style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names

  Widget _buildShimmerEffect(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.white30,
      highlightColor: Colors.white,
      child: Container(
        height: size.height / 2 - 1,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              height: size.height * 0.2,
              child: Lottie.asset(
                  "assets/lottieanimations/139432-person-riding-bicycle.json"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 25,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 20,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildData(API api, Size size) {
    return Container(
      height: size.height * 0.5 - 50,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: size.height * 0.24,
            child: Lottie.asset(
                "assets/lottieanimations/139432-person-riding-bicycle.json"),
          ),
          Text('${api.personalData['name']}',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: size.height * 0.026,
                fontWeight: FontWeight.bold,
              )),
          const Divider(
            color: Colors.white,
            thickness: 1,
            indent: 100,
            endIndent: 100,
          ),
          Text(
            '${api.personalData['usn']}',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: size.height * 0.016,
              fontWeight: FontWeight.w400,
              letterSpacing: 2,
            ),
          )
        ],
      ),
    );
  }
}
