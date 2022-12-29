import 'package:flutter/material.dart';
import 'package:tp3_flutter/main.dart';
import 'package:tp3_flutter/presentation/quiz_screen.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choisir un Thème"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(80),
          child: ListView(
            children: themesList
                .map((theme) => ElevatedButton(
                      child: Text(theme),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizPage(theme: theme),
                            ));
                      },
                    ))
                .toList(),
          )),
    );
  }
}
