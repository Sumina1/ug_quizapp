import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ug_quizapp/Model/helpline.dart';
import 'package:ug_quizapp/Model/quizModel.dart';
import 'package:ug_quizapp/Model/quizesModel.dart';

class StartQuiz extends StatefulWidget {
  final slug;

  const StartQuiz({Key key, this.slug}) : super(key: key);
  @override
  _StartQuizState createState() => _StartQuizState();

}
class _StartQuizState extends State<StartQuiz> {
   Future<QuizModel> futureQuiz;
   Future<Helpline> futurehelpline;



  String value= '';
  int points =0;
  int initialindex = 0;
  GetQuiz getQuizobj = GetQuiz();
   FetchPeekaboo getHelpline = FetchPeekaboo();
  @override
  void initState() {
    super.initState();
    futureQuiz= getQuizobj.fetechquizdata(widget.slug.toString());
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: futureQuiz,

            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(initialindex);
              if (snapshot.data != null) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ElevatedButton(onPressed: ()  {


                          print(snapshot.data.data.quiz.questions[initialindex].id);

                          getHelpline.createPeekaboo(snapshot.data.data.quiz.questions[initialindex].id).then((value) => print(value.data[0].id));






                      },
                          child: Text('Pekaaboo')),

                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      Container(
                          child: Text('${snapshot.data.data.quiz.questions[initialindex].question}', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black))),
                      ListView.builder(

                          itemCount: snapshot.data.data.quiz.questions[initialindex].options.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index){
                            return Padding(

                              padding:  EdgeInsets.all(10),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    if(initialindex < snapshot.data.data.quiz.questions.length -1){

                                    if(snapshot.data.data.quiz.questions[initialindex].options[index].isCorrect==true){
                                      points = points + snapshot.data.data.quiz.questions[initialindex].options[index].point;
                                      print(points);

                                      initialindex = initialindex+1;
                                    }
                                    else {
                                      points = points - snapshot.data.data.quiz.questions[initialindex].options[index].point;
                                      initialindex = initialindex+1;


                                    }   }

                                  });
                                },

                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.1,
                                  width: MediaQuery.of(context).size.width*0.1,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.black,)),
                                  child: Text('${snapshot.data.data.quiz.questions[initialindex].options[index].value}',
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),),
                              ),
                            );}
                      ),

                    ],

                  ),
                );


              }

              else{
                return CircularProgressIndicator();
              }
            }
        ),
      ),
    );
  }

}

