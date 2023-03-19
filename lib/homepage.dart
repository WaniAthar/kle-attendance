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
    return Scaffold(
      body: Container(
        color: Colors.orange,
        child: FutureBuilder(
          future: api.getData(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildShimmerEffect();
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  SizedBox(
                    height: 250,
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
              return _buildData(api);
            }
          },
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.white30,
      highlightColor: Colors.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            height: 200,
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
    );
  }

  Widget _buildData(API api) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5),
          height: 200,
          child: Lottie.asset(
              "assets/lottieanimations/139432-person-riding-bicycle.json"),
        ),
        Text('${api.personalData['name']}',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 25,
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
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
          ),
        )
      ],
    );
  }
}
