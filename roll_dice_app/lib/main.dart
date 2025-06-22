import 'package:flutter/material.dart';

import 'package:roll_dice_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(77, 153, 177, 232),
          Color.fromARGB(255, 236, 158, 158),
        ),
      ),
    ),
  );
}
