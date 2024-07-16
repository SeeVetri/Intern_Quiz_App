import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  final bool isCorrect;
  final VoidCallback onNext;

  FeedbackScreen({required this.isCorrect, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        automaticallyImplyLeading: false, // Disable back button
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isCorrect ? Colors.greenAccent.shade700 : Colors.redAccent.shade700,
              isCorrect ? Colors.green.shade600 : Colors.red.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                isCorrect ? 'assets/images/correct.gif' : 'assets/images/incorrect.gif',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      isCorrect ? 'Correct Answer!' : 'Incorrect Answer',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect ? Colors.green : Colors.red,
                      size: 80,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  foregroundColor: isCorrect ? Colors.green : Colors.red, backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 10,
                ),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    isCorrect ? 'Next Question' : 'Try Again',
                    key: ValueKey<bool>(isCorrect),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
