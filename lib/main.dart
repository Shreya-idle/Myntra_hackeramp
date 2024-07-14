import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myntra_project/pages/Delivery_page1.dart';
import 'package:myntra_project/pages/productdescription_page.dart';
import 'package:myntra_project/pages/Home_page.dart';
import 'package:myntra_project/pages/weeklyquiz.dart'; // Import the QuizScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool _quizShown = false;

  @override
  void initState() {
    super.initState();
    // Start a timer that will call _showQuiz after 1 minute (60 seconds)
    Timer(Duration(minutes: 1), _showQuiz);
  }

  void _showQuiz() {
    if (!_quizShown) {
      print('Showing quiz dialog'); // Debug statement
      _quizShown = true; // Ensure the quiz is only shown once
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Time!'),
            content: Text('It\'s time to take a quiz.'),
            actions: <Widget>[
              TextButton(
                child: Text('Start Quiz'),
                onPressed: () {
                  Navigator.of(context).pop();
                  navigatorKey.currentState!.push(MaterialPageRoute(
                    builder: (context) => QuizScreen(),
                  ));
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Myntra'),
    );
  }
}

