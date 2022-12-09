import 'package:flutter/material.dart';
import 'package:tic_tac_toy_flutter/screens/hom_screen.dart';

void main() {
  runApp(application());
}

class application extends StatelessWidget {
  const application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: homeScreen());
  }
}
