import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';

void main() {
  runApp(
    const Quiz(),
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
