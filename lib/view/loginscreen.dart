import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase/sharedpreference.dart';
import 'forgot_password.dart';
import 'register.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({
    super.key,
  });

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isExpanded = false;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  //color: Colors.amber,
                  height: 450,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(
                        color: _isExpanded
                            ? Colors.black54
                            : const Color.fromARGB(255, 0, 156, 234),
                        width: _isExpanded ? 5.0 : 3.0,
                      ),
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Login ",
                        style: GoogleFonts.sanchez(
                            fontSize: 45, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextField(
                          controller: emailcontrol,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 2, 34, 61),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Emailid",
                            labelStyle:
                                GoogleFonts.aBeeZee(color: Colors.black54),
                            suffixIcon: const Icon(
                              Icons.email_outlined,
                              size: 30,
                              color: Colors.black45,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextField(
                          controller: password,
                          obscureText: !hidePassword,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 2, 34, 61),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Password",
                              labelStyle:
                                  GoogleFonts.aBeeZee(color: Colors.black54),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                child: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.blue))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? ",
                              style: TextStyle(color: Colors.black54)),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const Registeruser();
                              }));
                            },
                            child: const Text(
                              "Register now!",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (emailcontrol.text.trim().isNotEmpty &&
                              password.text.trim().isNotEmpty) {
                            try {
                              var userCredentials = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailcontrol.text,
                                      password: password.text);

                              await SessionData.storeSessionData(
                                loginData: true,
                                emailId: userCredentials.user!.email!,
                              );
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const HomeScreen();
                              }));
                              emailcontrol.clear();
                              password.clear();
                            } catch (e) {
                              log("${e}");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Login failed: ${e.toString()}"),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 20),
                            child: Text(
                              "Sig in",
                              style: GoogleFonts.bonaNova(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const ForgotPassword();
                          }));
                        },
                        child: Container(
                          child: const Text("Forgot Password >"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
