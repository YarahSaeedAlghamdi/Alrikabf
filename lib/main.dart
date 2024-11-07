import 'package:alrikabf/Pages/CameraFeed_Page.dart';
import 'package:alrikabf/Pages/Login_page.dart';
import 'package:alrikabf/Pages/help_page.dart';
import 'package:alrikabf/Pages/history_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:alrikabf/Pages/about_us.dart';
import 'package:alrikabf/Pages/contact%D9%80us.dart';
import 'package:alrikabf/Pages/home_page.dart';
import 'package:alrikabf/auth/Main_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/contact_us': (context) => ContactUs(),
        '/about_us': (context) => AboutUs(),
        '/help_page': (context) => HelpPage(),
        '/check_page': (context) => MainPage(),
        '/history_page': (context) => HistoryPage(),
        '/camera_page': (context) => CameraFeedPage()
      },
    );
  }
}
