import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import your default home screen

class MarksScreen extends StatelessWidget {
  final int score;

  MarksScreen({required this.score}); // Constructor with score parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marks'),
        automaticallyImplyLeading: false, // Disable back button
        backgroundColor: Colors.white, // Customize app bar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.deepPurple], // Gradient colors
          ),
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Your score is:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$score',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to your default home screen
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'End Quiz',
                      style: TextStyle(fontSize: 18, color: Colors.black,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
