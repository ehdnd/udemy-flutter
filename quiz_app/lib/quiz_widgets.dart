import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryText extends StatelessWidget {
  const SummaryText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        color: const Color.fromARGB(255, 255, 255, 255),
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class QuestionIndexWidget extends StatelessWidget {
  const QuestionIndexWidget(this.questionIndex, this.isCorrect, {super.key});

  final int questionIndex;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCorrect
            ? const Color.fromARGB(255, 150, 198, 240)
            : const Color.fromARGB(255, 249, 133, 241),
      ),
      child: Center(
        child: Text(
          (questionIndex + 1).toString(),
          style: GoogleFonts.lato(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class QuestionText extends StatelessWidget {
  const QuestionText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class CorrectAnswerText extends StatelessWidget {
  const CorrectAnswerText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        color: const Color.fromARGB(255, 150, 198, 240),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class UserAnswerText extends StatelessWidget {
  const UserAnswerText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        color: const Color.fromARGB(255, 249, 133, 241),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
