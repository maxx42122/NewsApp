import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class Registeruser extends StatefulWidget {
  const Registeruser({super.key});

  @override
  State<Registeruser> createState() => _RegisteruserState();
}

class _RegisteruserState extends State<Registeruser>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create an Account",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 6,
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: emailController,
                      hintText: "Enter Email",
                      icon: Icons.email_outlined,
                    ),
                    _buildTextField(
                      controller: nameController,
                      hintText: "Enter your name",
                      icon: Icons.local_hospital_outlined,
                    ),
                    _buildTextField(
                      controller: passwordController,
                      hintText: "Password",
                      icon: Icons.lock_outline,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _Registeruser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 6,
              ),
              icon: const Icon(
                Icons.check_circle_outline,
                size: 28,
                color: Colors.white,
              ),
              label: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 16, color: Color(0xFF424242)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black38),
          prefixIcon: Icon(
            icon,
            color: Colors.blue,
          ),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color.fromARGB(31, 44, 41, 41)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromRGBO(118, 117, 164, 1),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _Registeruser() async {
    if (emailController.text.trim().isNotEmpty &&
        nameController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      try {
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        log("User: $userCredential");
        log("Sign-up successful");

        Map<String, dynamic> data = {
          "emailId": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "Name": nameController.text.trim(),
        };

        await FirebaseFirestore.instance
            .collection("User")
            .doc(emailController.text.trim())
            .set(data);

        _showAnimatedSnackBar(
            "Registration Successful!", AnimatedSnackBarType.success);
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (error) {
        _showAnimatedSnackBar("Registration Failed: ${error.message}",
            AnimatedSnackBarType.error);
      }
    } else {
      _showAnimatedSnackBar(
          "Please fill in all fields.", AnimatedSnackBarType.warning);
    }
  }

  void _showAnimatedSnackBar(String message, AnimatedSnackBarType type) {
    AnimatedSnackBar.material(
      message,
      duration: const Duration(seconds: 3),
      type: type,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    ).show(context);
  }
}
