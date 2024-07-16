import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'FeedbackScreen.dart';
import 'marks_screen.dart'; // Import the new FeedbackScreen widget

class QuizScreen3 extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen3> with TickerProviderStateMixin {
  final _firestore = FirebaseFirestore.instance;
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  List<DocumentSnapshot> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  late AnimationController _questionAnimationController;
  late AnimationController _optionsAnimationController;
  late Animation<double> _questionAnimation;
  late Animation<Offset> _optionsAnimation;
  Timer? _timer;
  int _timeLeft = 15; // Initial time left for the countdown

  // List of colors for option boxes
  List<Color> _optionColors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
  ];

  // Animation controllers and animations for each option box
  late AnimationController _option1Controller;
  late Animation<double> _option1Animation;
  late AnimationController _option2Controller;
  late Animation<double> _option2Animation;
  late AnimationController _option3Controller;
  late Animation<double> _option3Animation;
  late AnimationController _option4Controller;
  late Animation<double> _option4Animation;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _questionAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _questionAnimation = CurvedAnimation(
      parent: _questionAnimationController,
      curve: Curves.easeInOut,
    );

    _optionsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _optionsAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _optionsAnimationController,
      curve: Curves.easeInOut,
    ));

    // Initialize animation controllers and animations for each option box
    _option1Controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _option1Animation = CurvedAnimation(
      parent: _option1Controller,
      curve: Curves.easeInOut,
    );
    _option2Controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _option2Animation = CurvedAnimation(
      parent: _option2Controller,
      curve: Curves.easeInOut,
    );
    _option3Controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _option3Animation = CurvedAnimation(
      parent: _option3Controller,
      curve: Curves.easeInOut,
    );
    _option4Controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _option4Animation = CurvedAnimation(
      parent: _option4Controller,
      curve: Curves.easeInOut,
    );

    _questionAnimationController.forward();
    _optionsAnimationController.forward();

    // Start playing background music
    _playBackgroundMusic();

    // Start the timer when the questions are loaded
    _startTimer();
  }

  Future<void> _loadQuestions() async {
    final querySnapshot = await _firestore.collection('questions3').get();
    setState(() {
      _questions = querySnapshot.docs;
    });
  }

  void _playBackgroundMusic() async {
    try {
      await _audioPlayer.open(
        Audio('assets/background_quiz.mp3'),
        autoStart: true,
        loopMode: LoopMode.single,
        volume: 0.5, // Set volume to 50% (0.0 to 1.0)
      );
    } catch (e) {
      print('Error playing background music: $e');
    }
  }

  void _playSound(bool correct) async {
    final soundPath = correct ? 'assets/correct.mp3' : 'assets/incorrect.mp3';
    await _audioPlayer.open(Audio(soundPath));
    _audioPlayer.play();
  }

  void _answerQuestion(bool correct) {
    _playSound(correct);
    setState(() {
      if (correct) _score++;
    });

    _timer?.cancel(); // Cancel the timer when an answer is selected

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackScreen(
          isCorrect: correct,
          onNext: _nextQuestion,
        ),
      ),
    );
  }

  void _nextQuestion() {
    Navigator.pop(context); // Close the feedback screen
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _questionAnimationController.reset();
        _questionAnimationController.forward();
        _optionsAnimationController.reset();
        _optionsAnimationController.forward();
        _timeLeft = 15; // Reset time left for the next question
      });
      _startTimer(); // Start the timer for the next question
      _playBackgroundMusic();
    } else {
      // Quiz finished
      _audioPlayer.stop(); // Stop background music
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MarksScreen(score: _score)),
      );
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          timer.cancel(); // Cancel the timer
          // Navigate to feedback screen if timer runs out
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeedbackScreen(
                isCorrect: false, // Consider as incorrect if no answer in time
                onNext: _nextQuestion,
              ),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
          backgroundColor: Colors.white,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentQuestionIndex];
    final options = (question['options'] as List).cast<String>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeTransition(
                opacity: _questionAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          question['word'],
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.purpleAccent,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'FIND THE CORRECT TRANSLATION ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Countdown Timer Widget
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$_timeLeft seconds left',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.topCenter,
                child: SlideTransition(
                  position: _optionsAnimation,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return _buildOptionButton(options[index], index, question);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option, int index, DocumentSnapshot question) {
    AnimationController controller;
    Animation<double> animation;

    switch (index) {
      case 0:
        controller = _option1Controller;
        animation = _option1Animation;
        break;
      case 1:
        controller = _option2Controller;
        animation = _option2Animation;
        break;
      case 2:
        controller = _option3Controller;
        animation = _option3Animation;
        break;
      case 3:
        controller = _option4Controller;
        animation = _option4Animation;
        break;
      default:
        controller = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 500),
        );
        animation = CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        );
        break;
    }

    controller.forward();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, 0.5),
              end: Offset(0, 0),
            ).animate(animation),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () => _answerQuestion(option == question['translation']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _optionColors[index], // Assign color dynamically
                  padding: EdgeInsets.symmetric(horizontal: 27, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 10,
                ),
                // Explicitly set the text style with black color
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black, // Text color
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _questionAnimationController.dispose();
    _optionsAnimationController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    _timer?.cancel(); // Cancel the timer when disposing
    _audioPlayer.dispose(); // Dispose of the audio player
    super.dispose();
  }
}

