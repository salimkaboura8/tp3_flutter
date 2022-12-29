import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tp3_flutter/business_logic/quiz_manager.dart';
import 'package:tp3_flutter/presentation/add_question_page.dart';
import 'package:tp3_flutter/presentation/themes_list_page.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
QuizManager quizManager = QuizManager();
List<String> themesList = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getThemes();
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

  void getThemes() async {
    themesList = await quizManager.getThemes();
  }
}
