import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List> getQuestions({required String theme}) async {
    final snapshot =
        await _firestore.collection('themes').doc(theme.toLowerCase()).get();
    final questions = snapshot.data()!['questions'];
    return questions;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getThemes() async {
    return await _firestore.collection('themes').get();
  }

  void addQuestion(
      TextEditingController qcntrl, String selectedTheme, String answer) {
    CollectionReference themesRef = _firestore.collection('/themes');

    dynamic field = qcntrl.text + ' : ' + answer;

    themesRef
        .doc(selectedTheme.toLowerCase()) // <-- Document ID
        .update({
          'questions': FieldValue.arrayUnion([field])
        })
        .then((_) => {})
        .catchError((error) => print('Add failed: $error'));
  }
}
