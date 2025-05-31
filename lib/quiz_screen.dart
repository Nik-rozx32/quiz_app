import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_provider.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final question = quizProvider.currentQuestion;

    bool isLastQuestion =
        quizProvider.currentIndex == quizProvider.question.length - 1;

    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: quizProvider.currentIndex < quizProvider.question.length
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Q${quizProvider.currentIndex + 1}: ${question.questionText}',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(question.options.length, (index) {
                    return RadioListTile<int>(
                      title: Text(question.options[index]),
                      value: index,
                      groupValue: _selectedOptionIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionIndex = value;
                        });
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white),
                      onPressed: _selectedOptionIndex != null
                          ? () {
                              quizProvider
                                  .answerQuestion(_selectedOptionIndex!);
                              setState(() {
                                _selectedOptionIndex = null;
                              });
                            }
                          : null,
                      child: Text(isLastQuestion ? 'Submit' : 'Next'),
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      "Quiz Complete!",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Your score: ${quizProvider.score} / ${quizProvider.question.length}",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        quizProvider.resetQuiz();
                        setState(() {
                          _selectedOptionIndex = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white),
                      child: Text("Restart"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
