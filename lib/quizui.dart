

import 'package:flutter/material.dart';
import 'package:ug_quizapp/fetechapi.dart';
import 'package:ug_quizapp/model.dart';
class QUIZ_UI extends StatefulWidget {
  @override
  _QUIZ_UIState createState() => _QUIZ_UIState();
}

class _QUIZ_UIState extends State<QUIZ_UI> {


  FetchApi obj = FetchApi();
  @override

  Widget build(BuildContext context) {
    return FutureBuilder<Welcome>(
      future: obj.fetechdata(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text("");
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
