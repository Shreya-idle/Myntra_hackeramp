import 'package:flutter/material.dart';
import 'dart:async';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int selectedOptionIndex = -1; // Initialize selectedOptionIndex
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
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Time!'),
            content: Text('It\'s time to take a quiz.'),
            actions: <Widget>[
              TextButton(
                child: Text('Start Quiz'),
                onPressed: () {
                  print('Quiz started'); // Debug statement
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Quiz'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'What type of top is it?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Image.asset(
                  'assets/images/Homepage_images/tshirt.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Options
          buildOption(0, 'boring'),
          buildOption(1, 'cool'),
          buildOption(2, 'Supercool'),
          buildOption(3, 'Trendy'),
        ],
      ),
    );
  }

  Widget buildOption(int index, String text) {
    bool isSelected = selectedOptionIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOptionIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.pink : Colors.pinkAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.pink.withOpacity(0.1) : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.pink : Colors.pinkAccent,
          ),
        ),
      ),
    );
  }
}
