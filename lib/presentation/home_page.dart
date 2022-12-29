import 'package:flutter/material.dart';
import 'package:tp3_flutter/presentation/themes_list_page.dart';

import 'add_question_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 200,
                height: 200,
                child: Image.asset(('assets/logo.png'))),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThemePage(),
                    ),
                  );
                },
                child: Text("Jouer"),
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionForm(),
                    ),
                  );
                },
                child: Text("Ajouter une question"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
