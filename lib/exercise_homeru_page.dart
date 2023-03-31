import 'package:flutter/material.dart';

class ExerciseHomeruPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ほめるページ"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/yokohama.png'),
          ],
        ),
      ),
    );
  }
}
