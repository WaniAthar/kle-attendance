import 'package:after_layout/after_layout.dart';
import 'package:attendance/screens/input.dart';
import 'package:attendance/screens/slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with AfterLayoutMixin<FirstScreen> {
  Future checkFirstSeen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool firstScreenSeen_ = (pref.getBool('firstScreenSeen') ?? false);
    // firstScreenSeen_ = true;
    if (firstScreenSeen_) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SLider()));
    } else {
      await pref.setBool('firstScreenSeen', true);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const InputData())));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) =>
      Future.delayed(const Duration(seconds: 3), () => checkFirstSeen());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: Lottie.asset("assets/lottieanimations/geometric.json"),
          ),
        ],
      ),
    );
  }
}