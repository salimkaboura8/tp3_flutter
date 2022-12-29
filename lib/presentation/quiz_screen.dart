import 'package:flutter/material.dart';
import 'package:tp3_flutter/main.dart';

class QuizPage extends StatefulWidget {
  final String theme;

  QuizPage({required this.theme});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<String> _qaList = [];
  List<String> _questionsList = [];
  List<String> _answersList = [];

  int _score = 0;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _getQuestionsForTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz App')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40),
                child: Text(_questionsList[_index],
                    style: TextStyle(fontSize: 20)),
              ),
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    _answerQuestion(true, context);
                  },
                  child: Text('Vrai'),
                ),
              ),
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    _answerQuestion(false, context);
                  },
                  child: Text('Faux'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getQuestionsForTheme() async {
    List questions = await quizManager.getQuestions(widget.theme);

    print('**' + questions.toString());
    setState(() {
      List.from(questions).forEach((element) {
        _qaList.add(element);
      });
      fillQuestionsAnswers(_qaList);
    });
  }

  void fillQuestionsAnswers(List<String> qaList) {
    for (var i = 0; i < qaList.length; i++) {
      _questionsList.add(qaList.elementAt(i).split(':').elementAt(0).trim());
      _answersList.add(qaList.elementAt(i).split(':').elementAt(1).trim());
    }
    print(_questionsList);
    print(_answersList);
  }

  void _answerQuestion(bool answer, BuildContext context) {
    if (answer && _answersList[_index].toLowerCase().contains('v')) {
      _score++;
    }
    if (!answer && _answersList[_index].toLowerCase().contains('x')) {
      _score++;
    }
    if (_index < _questionsList.length - 1) {
      setState(() {
        _index++;
      });
    } else {
      _index = 0;
      _showScore(context);
    }
  }

  void _showScore(BuildContext context) {
    int finalScore = _score;
    _score = 0;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Quiz score'),
            content: Text(
                'Votre score est de $finalScore sur ${_questionsList.length}'),
            actions: [
              ElevatedButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
