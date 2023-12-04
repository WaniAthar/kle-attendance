import 'package:attendance/api/api_handler_provider.dart';
import 'package:attendance/screens/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const Attendd());
  });
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor:
        Colors.white,
    systemNavigationBarIconBrightness: Brightness
        .dark,
  ));
}

class Attendd extends StatefulWidget {
  const Attendd({super.key});

  @override
  State<Attendd> createState() => _AttenddState();
}

class _AttenddState extends State<Attendd> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => API(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Attendd',
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            toolbarHeight: 60,
            iconTheme:
                IconThemeData(color: Colors.orange, size: screenWidth * 0.06),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light),
            backgroundColor: Colors.orange,
            scrolledUnderElevation: 0,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.06,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: const FirstScreen(),
        // home: const FirstScreen(),
      ),
    );
  }
}
