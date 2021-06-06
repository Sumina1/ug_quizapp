


import 'package:flutter/material.dart';
import 'package:ug_quizapp/Model/quizModel.dart';

class StartQuiz extends StatefulWidget {
  final slug;

  const StartQuiz({Key key, this.slug}) : super(key: key);
  @override
  _StartQuizState createState() => _StartQuizState();

}


class _StartQuizState extends State<StartQuiz> {
  GetQuiz getQuizobj = GetQuiz();


  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future:getQuizobj.fetechquizdata(widget.slug.toString()),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
    return ListView.builder(
    itemCount: snapshot.data.data.quiz.questions.length,
    shrinkWrap: true,
    primary: false,
    itemBuilder: (BuildContext context, int index) {
    return Text('${snapshot.data.data.quiz.questions[index].question}');
  }
    );
    }


    else{
      return CircularProgressIndicator();
    }
}
    );
  }
  }

