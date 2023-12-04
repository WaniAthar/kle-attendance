import 'package:attendance/api/api_handler_provider.dart';
import 'package:attendance/widgets/nav_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class COE extends StatelessWidget {
  const COE({super.key});

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
        title: const Text("COE"),
        actions: [
          NavButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const COE(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                ),
              );
            },
            margin: const EdgeInsets.only(right: 10),
            icon: const Icon(
              Icons.refresh,
              color: Colors.orange,
            ),
            tooltip: "Refresh",
          )
        ],
      ),
      body: const CalenderRenderer(),
    );
  }
}

class CalenderRenderer extends StatefulWidget {
  const CalenderRenderer({super.key});
  @override
  State<CalenderRenderer> createState() => _CalenderRendererState();
}

class _CalenderRendererState extends State<CalenderRenderer> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    final api = Provider.of<API>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            height: deviceHeight * 0.1,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "Tap the colours for Indication",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, color: Colors.black54),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: deviceHeight * 0.048,
                      width: deviceHeight * 0.048,
                      decoration: BoxDecoration(
                        color: Colors.red[200],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Tooltip(
                        message: "Holidays",
                        showDuration: const Duration(milliseconds: 2000),
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color: Colors.red[200],
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                    Container(
                      height: deviceHeight * 0.048,
                      width: deviceHeight * 0.048,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Tooltip(
                        message: "Marks/Attendance Display",
                        showDuration: const Duration(milliseconds: 2000),
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                    Container(
                      height: deviceHeight * 0.048,
                      width: deviceHeight * 0.048,
                      decoration: BoxDecoration(
                        color: Colors.indigo[200],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Tooltip(
                        message: "Feedback",
                        showDuration: const Duration(milliseconds: 2000),
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color: Colors.indigo[200],
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                    Container(
                      height: deviceHeight * 0.048,
                      width: deviceHeight * 0.048,
                      decoration: BoxDecoration(
                        color: Colors.lime[300],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Tooltip(
                        message: "Minor Exams",
                        showDuration: const Duration(milliseconds: 2000),
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color: Colors.lime[300],
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: api.getCOE(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: deviceHeight * 0.5,
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                    ),
                  ),
                );
              } else {
                WebViewController webViewController = WebViewController()
                  ..loadHtmlString(api.coeHtml!)
                  ..setJavaScriptMode(JavaScriptMode.unrestricted);

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.white),
                        margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 30),
                        height: deviceHeight * 0.55,
                        padding: const EdgeInsets.all(7),
                        child: WebViewWidget(
                          controller: webViewController,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Shimmer.fromColors(
                          period: const Duration(seconds: 3),
                          baseColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          highlightColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Pinch to zoom",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: deviceHeight * 0.025,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.pinch_rounded,
                                  size: deviceHeight * 0.035,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
