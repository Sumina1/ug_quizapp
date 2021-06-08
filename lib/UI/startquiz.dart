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
  String peekaboovalue = '';
  List peekaboovalues;

  Color containercolor = Colors.white;
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
              if (snapshot.data != null) {

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ElevatedButton(onPressed: ()  async{
                          var value = await getHelpline.createPeekaboo(snapshot.data.data.quiz.questions[initialindex].id);
                          peekaboovalues=value.data;
                          print(peekaboovalues);
                          setState(() {

                          });

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
                            if(peekaboovalues!=null){
                              peekaboovalue="${peekaboovalues[index].percent.toString()}%";
                            }
                            return Padding(
                              padding:  EdgeInsets.all(10),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    if(initialindex < snapshot.data.data.quiz.questions.length -1){
                                    if(snapshot.data.data.quiz.questions[initialindex].options[index].isCorrect==true){
                                      points = points + snapshot.data.data.quiz.questions[initialindex].options[index].point;
                                      initialindex = initialindex+1;
                                      containercolor = Colors.green;


                                    }
                                    else {
                                      points = points - snapshot.data.data.quiz.questions[initialindex].options[index].point;
                                      initialindex = initialindex+1;
                                      containercolor = Colors.white;

                                    }   }

                                  });
                                },

                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.1,
                                  width: MediaQuery.of(context).size.width*0.1,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: containercolor,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.black,)),
                                  child: Row(

                                    children: [
                                      Text('${snapshot.data.data.quiz.questions[initialindex].options[index].value}',
                                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                      SizedBox(width: 20,),
                                      Text("${peekaboovalue}")
                                    ],
                                  ),),
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
   Color getColorForOption(Option option, Question question) {
     final isSelected = option == questions[initialindex].question;

     if (!isSelected) {
       return Colors.grey.shade200;
     } else {
       return option.isCorrect ? Colors.green : Colors.red;
     }
   }

}

