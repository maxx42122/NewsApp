import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/view/loginscreen.dart';

import 'view/homepage.dart';
import 'view/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCUwcuqsYUouoy4jivNcOX3KO1hU385Glg",
          appId: "1:704687273997:android:4be050b605fb2386427d44",
          messagingSenderId: "704687273997",
          projectId: "newsapp-7a926"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          //HomeScreen()
          SplashScreen(),
    );
  }
}
