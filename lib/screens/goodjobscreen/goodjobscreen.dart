import 'package:flutter/material.dart';

class GoodJobScreen extends StatelessWidget {
  const GoodJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Good Job",
          style: TextStyle(
            fontFamily: "Andika2",
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Color(0xff3E8B3A),
          ),
        ),
      ),
    );
  }
}
