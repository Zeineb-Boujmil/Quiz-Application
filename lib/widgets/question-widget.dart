import 'package:flutter/material.dart';
import '../constants.dart';


class Questionwidget extends StatelessWidget {
  const Questionwidget(
      {Key? key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(children: [
        const Image(
          image: AssetImage('../assets/thinking.png'),
          height: 100.0,
          ),
        Text(
        'Question ${indexAction + 1}/$totalQuestions:\n $question',
        style: const TextStyle(
          fontSize: 24.0,
          color: neutral,
        ),
      ),
      ] 
    ));
  }
}
