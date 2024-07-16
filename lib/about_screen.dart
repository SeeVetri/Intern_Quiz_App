import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      backgroundColor: Colors.purple[400],
      body: Stack(
        children: [
          Positioned(
            top: 20, // Adjust top positioning as needed
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/intro_quiz.png', // Replace with your image path
                height: 200, // Adjust height as needed
                width: 200, // Adjust width as needed
                fit: BoxFit.contain, // Adjust fit as needed
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quran Quiz App',
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'This is a Quran quiz app designed to help users learn more about the Quran through interactive quizzes.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 24),
                  AnimatedDecoration(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedDecoration extends StatefulWidget {
  @override
  _AnimatedDecorationState createState() => _AnimatedDecorationState();
}

class _AnimatedDecorationState extends State<AnimatedDecoration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<Offset>(
      begin: Offset(-1.0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        width: 150,
        height: 5,
        color: Colors.black,
      ),
    );
  }
}
