import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(QuranQuizApp());
}

class QuranQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(),
    );
  }
}
