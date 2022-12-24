import 'package:flutter/material.dart';
import '../models/question-model.dart';
import '../constants.dart';
import '../widgets/question-widget.dart';
import '../widgets/next-button.dart';
import '../widgets/option-card.dart';
import '../widgets/result_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Question> _questions = [
    Question(
        id: '11',
        title: 'what is 2+2',
        options: {'5': false, '20': false, '4': true}),
    Question(
        id: '12',
        title: 'what is 2*2',
        options: {'5': false, '20': true, '4': false}),
  ];
  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  void nextQuestion() {
    if (index == _questions.length - 1) {
       showDialog(context: context,
       barrierDismissible: false, 
       builder: (ctx) => ResultBox(
        result: score, 
        QuestionLenght: _questions.length,
        onPressed : startOver,
        ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('please select any option '),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected){
      return;
    } else {
      if (value)
        {  
          score ++;
        }

          setState(() {
            isPressed = true;
            isAlreadySelected = true;
          });
        }
    }

  void startOver(){
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: backGround,
        shadowColor: Colors.transparent,
        actions: [
          Padding(padding: const EdgeInsets.all(18.0),
          child: Text('Score: $score',
          style: const TextStyle(fontSize: 18.0),)
          )
        ]
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Questionwidget(
              question: _questions[index].title,
              indexAction: index,
              totalQuestions: _questions.length,
            ),
            const Divider(
              color: neutral,
            ),
            const SizedBox(height: 25.0),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap:() => checkAnswerAndUpdate(_questions[index].options.values.toList()[i]),
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
