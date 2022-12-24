import 'package:flutter/material.dart';
import '../constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({Key? key, 
  required this.result, 
  required this.QuestionLenght,
  required this.onPressed}) : super(key: key);
  
  final int result;
  final int QuestionLenght;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backGround,
      content: Padding(padding: const EdgeInsets.all(70.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Text('Score',
        style: TextStyle(color: neutral, fontSize: 22.0) ,
        ),
        const SizedBox(height: 20.0,),
        CircleAvatar(
          child: Text('$result/$QuestionLenght',
          style: TextStyle(fontSize: 30.0),
          ),
          radius: 60.0,
          backgroundColor: result == QuestionLenght/2 
            ? Colors.yellow 
            : result < QuestionLenght/2 
              ? incorrect
              : correct
        ),
        const SizedBox(height: 20.0,),
        Text(result == QuestionLenght/2 
            ? 'Almost there'
            : result < QuestionLenght/2 
              ? 'Try again'
              : 'Good Job!',
              style: const TextStyle(color: neutral),
              ),
              const SizedBox(height: 25.0,),
              GestureDetector(
                onTap: onPressed,
                child: const Text('Start over',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),),
              )
      ]),
      ),
    );
  }
}
