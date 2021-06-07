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
  int initialindex = 0;


  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      body: FutureBuilder(
          future:getQuizobj.fetechquizdata(widget.slug.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {

              //data.data.quiz.questions[0].options.map((x) => x.value
              //print('${snapshot.data.data.quiz.questions[index].question}');

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(

                  children: [
                    Container(
                      //'${snapshot.data.data.quiz.questions[index].options.map((x)=> x.value)}'

                        child: Text('${snapshot.data.data.quiz.questions[initialindex].question}', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black))),
                    Container(
                        width: MediaQuery.of(context).size.width*0.8,     height: MediaQuery.of(context).size.height*0.1,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(



                            border: Border.all(color: Colors.black,)),
                        child: Text('${snapshot.data.data.quiz.questions[initialindex].options.map((x) => x.value)}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black))),

                  ],
                ),
              );


            }

            else{
              return CircularProgressIndicator();
            }
          }
      ),
    );
  }
}

