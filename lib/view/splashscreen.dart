import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view/homepage.dart';
import 'package:news_app/view/loginscreen.dart';

import '../firebase/sharedpreference.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  void navigate(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        await SessionData.getSessionData();
        print("IS LOGIN : ${SessionData.isLogin}");
        if (SessionData.isLogin!) {
          print("NAVIGATE TO HOME");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return HomeScreen();
              },
            ),
          );
        } else {
          print("NAVIGATE TO LOGIN");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const Loginscreen();
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("IN BUILD");
    navigate(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                "assets/compass.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "News",
              style: GoogleFonts.exo2(
                fontSize: 60,
                fontWeight: FontWeight.w800,
                color: Colors.blue,
                letterSpacing: 4,
                // shadows: [
                //   BoxShadow(
                //       color: Colors.black,
                //       // blurRadius: 10,
                //       spreadRadius: 10,
                //       offset: Offset.fromDirection(0, 5)),
                //   BoxShadow(
                //       color: const Color.fromARGB(255, 79, 138, 210),
                //       // blurRadius: 10,
                //       spreadRadius: 10,
                //       offset: Offset.fromDirection(3, 3))
                // ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
