import 'package:flutter/material.dart';
import 'quiz_screen1.dart';
import 'quiz_screen2.dart';
import 'quiz_screen3.dart';
import 'quiz_screen4.dart';

class QuizSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Quiz Type'),
      ),
      backgroundColor: Colors.purple[400], // Set background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Image.asset(
                'assets/images/intro_quiz.png', // Replace with your asset path
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20.0), // Add spacing between the image and the first card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: Image.asset('assets/images/quiz.png', width: 80, height: 90), // Replace with your asset path
                title: Text(
                  'Quiz Type 1',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen1()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  child: Text('Start'),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: Image.asset('assets/images/quiz.png', width: 80, height: 90), // Replace with your asset path
                title: Text(
                  'Quiz Type 2',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  child: Text('Start'),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: Image.asset('assets/images/quiz.png', width: 80, height: 90), // Replace with your asset path
                title: Text(
                  'Quiz Type 3',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen3()), // Replace with the appropriate screen
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  child: Text('Start'),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: Image.asset('assets/images/quiz.png', width: 80, height: 90), // Replace with your asset path
                title: Text(
                  'Quiz Type 4',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen4()), // Replace with the appropriate screen
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  child: Text('Start'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
