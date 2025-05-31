import 'package:flutter/material.dart';
import 'models/question.dart';

class QuizProvider with ChangeNotifier {
  int _currentQuestion = 0;
  int _score = 0;

  final List<Question> _questions = [
    Question(
        questionText: 'What is the capital of France?',
        options: ['Paris', 'London', 'Rome', 'Berlin'],
        correctAnswer: 0),
    Question(
        questionText: 'What is the capital of France?',
        options: ['Paris', 'London', 'Rome', 'Berlin'],
        correctAnswer: 0)
  ];
  int get currentIndex => _currentQuestion;
  int get score => _score;
  List<Question> get question => _questions;
  Question get currentQuestion => _currentQuestion < _questions.length
      ? _questions[_currentQuestion]
      : _questions.last;

  void answerQuestion(int selectedIndex) {
    if (selectedIndex == currentQuestion.correctAnswer) {
      _score++;
    }
    _currentQuestion++;

    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestion = 0;
    _score = 0;
    notifyListeners();
  }
}
