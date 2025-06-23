import 'package:flutter/material.dart';
import 'package:quiz_app/start_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 117, 34, 173),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const StartScreen(),
        ),
      ),
    ),
  );
}

// class QuizAppContainer extends StatelessWidget {
//   const QuizAppContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.blueGrey,
//       ),
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               'assets/images/quiz-logo.png',
//               width: 250,
//               height: 250,
//             ),
//             const SizedBox(height: 80),
//             ElevatedButton(
//               onPressed: () {},
//               child: Text(
//                 "Start Quiz",
//                 style: TextStyle(color: Colors.blueGrey),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
