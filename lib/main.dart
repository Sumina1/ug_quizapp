import 'package:flutter/material.dart';
import 'package:ug_quizapp/fetechapi.dart';
import 'package:ug_quizapp/quizui.dart';

const BASE_URL = 'https://staging.ugbazaar.com/api/V2';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: QUIZ_UI(),
    );
  }
}
