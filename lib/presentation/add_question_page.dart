import 'package:flutter/material.dart';
import 'package:tp3_flutter/main.dart';

import '../business_logic/quiz_manager.dart';
import '../data/firebase_repository.dart';

class QuestionForm extends StatefulWidget {
  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  String? _selectedTheme;
  bool _selectedAnswer = true;

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter une question"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(80),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 120,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Thème'),
                        value: _selectedTheme,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 18,
                        elevation: 16,
                        style: TextStyle(color: Colors.black54),
                        underline: Container(
                          height: 2,
                          color: Colors.black54,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTheme = newValue!;
                          });
                        },
                        items: themesList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    TextField(
                      controller: questionController,
                      decoration: InputDecoration(
                        hintText: 'Question',
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: true,
                            groupValue: _selectedAnswer,
                            onChanged: (bool? value) {
                              setState(() {
                                _selectedAnswer = value!;
                              });
                            }),
                        Text(
                          'Vrai',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                            value: false,
                            groupValue: _selectedAnswer,
                            onChanged: (bool? value) {
                              setState(() {
                                _selectedAnswer = value!;
                              });
                            }),
                        const Text(
                          'Faux',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            String answer = '';
                            if (questionController.text.isNotEmpty &&
                                _selectedTheme != null) {
                              answer = 'VRAI';
                              if (!_selectedAnswer) {
                                answer = 'FAUX';
                              }
                              quizManager.addQuestion(
                                  questionController, _selectedTheme!, answer);
                            }
                          },
                          child: Text("Ajouter"),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }
}
