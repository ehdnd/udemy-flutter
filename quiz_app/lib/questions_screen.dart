import 'package:flutter/material.dart';
import 'package:quiz_app/models/answer_button.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('The question..'),
          SizedBox(height: 30),
          AnswerButton(),
          AnswerButton(),
          AnswerButton(),
        ],
      ),
    );
  }
}
