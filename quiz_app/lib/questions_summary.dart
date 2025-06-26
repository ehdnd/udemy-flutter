import 'package:flutter/material.dart';

import 'package:quiz_app/quiz_widgets.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData
              .map(
                (data) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuestionIndexWidget(
                      ((data['questionIndex'] as int) + 1).toString(),
                      data['correctAnswer'] == data['userAnswer'],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QuestionText(data['question'] as String),
                          const SizedBox(height: 10),
                          CorrectAnswerText(data['correctAnswer'] as String),
                          const SizedBox(height: 5),
                          UserAnswerText(data['userAnswer'] as String),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
