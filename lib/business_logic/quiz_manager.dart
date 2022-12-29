import 'package:flutter/material.dart';

import '../data/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizManager {
  final FirebaseRepository _repository = FirebaseRepository();

  Future<List<dynamic>> getQuestions(String theme) async {
    List questions = await _repository.getQuestions(theme: theme);
    return questions;
  }

  void addQuestion(
      TextEditingController qcntrl, String selectedTheme, String answer) {
    _repository.addQuestion(qcntrl, selectedTheme, answer);
    qcntrl.clear();
  }

  Future<List<String>> getThemes() async {
    final QuerySnapshot querySnapshot = await _repository.getThemes();
    final themes = querySnapshot.docs.map((doc) => doc.id).toList();
    themes.map((theme) => theme[0].toUpperCase() + theme.substring(1));
    return themes
        .map((theme) => theme[0].toUpperCase() + theme.substring(1))
        .toList();
  }

  int calculateScore(List<String> questions, List<String> answers) {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (questions[i] == answers[i]) {
        score++;
      }
    }
    return score;
  }
}
