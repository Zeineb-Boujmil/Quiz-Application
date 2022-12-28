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
        id: '1',
        title: 'What sentence uses the present perfect tense correctly?',
        options: {'I have visited the Colosseum last year.': false,
        "He's spoken to me ten minutes ago.": false, 
        'She has lived in Barcelona all her life.': true}),
    Question(
        id: '2',
        title: 'In which sentence is "Gradually" used in the most appropriate position?',
        options: {'Gradually, I accepted her as one of the family': true, 
        'I accepted gradually her as one of the family': false,
        }),
        Question(
        id: '3',
        title: 'Which third conditional sentence is correct?',
        options: {'If I would have seen you, I have had said hello.': false,
        "If I had seen you, I would have said hello.": true, 
        'I have had said hello If I would have seen you.': false}),
        Question(
        id: '4',
        title: "He doesn't like the boss.\n ________ I.",
        options: {'Neither do': true,
        "Neither does": false, 
        "Neither don't": false}),
        Question(
        id: '5',
        title: "Which short answer is NOT correct?\n 'Do you think we will make it in time?'\n'_______'",
        options: {"I don't suppose not.": true,
        "I don't suppose so.": false, 
        "I suppose not": false}),
        Question(
        id: '6',
        title: "I will lend you the book ________ you return it",
        options: {"in case": false,
        "so far so": false, 
        "so long so": true}),
        Question(
        id: '7',
        title: "Levi was eagerly ________ her arrival.",
        options: {"supposing": false,
        "anticipating": true, 
        "pretending": false}),
        Question(
        id: '8',
        title: "Which sentence is correct?",
        options: {"Students are not allowed to eat in class.": true,
        "Students are not let to eat in class.": false, 
        "Both are correct.": false}),
        Question(
        id: '9',
        title: "Luckily, the rescue came __________.",
        options: {"in the nick of minute": false,
        "in the nick of date": false, 
        "in the nick of time": true}),
        Question(
        id: '10',
        title: 'Which sentence correctly reports this question?\n"what are you doing?"',
        options: {"He asked me what I am doing": false,
        "He asked me what I was doing": true, 
        "He asked me what am I doing": false}),
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
