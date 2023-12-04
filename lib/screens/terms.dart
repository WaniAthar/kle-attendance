import 'package:attendance/widgets/nav_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TOS extends StatelessWidget {
  const TOS({super.key});
  final terms = """
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
          "Terms of Service",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 25),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Text(terms,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
