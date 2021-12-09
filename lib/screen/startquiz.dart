

import 'package:flutter/material.dart';
import 'package:ug_quizapp/DataFetch/fetechapi.dart';
import 'package:ug_quizapp/Model/helpline.dart';
import 'package:ug_quizapp/Model/quizModel.dart';
import 'package:ug_quizapp/Model/submit.dart';

import 'package:ug_quizapp/UI/selectquiz.dart';
import 'package:ug_quizapp/UI/welcome.dart';


class StartQuiz extends StatefulWidget {
  final slug;
  final nickname;
  final anonymous;




  const StartQuiz({Key key, this.slug, this.nickname, this.anonymous}) : super(key: key);
  @override
  _StartQuizState createState() => _StartQuizState();

}
class _StartQuizState extends State<StartQuiz> with TickerProviderStateMixin{
  Future<QuizModel> futureQuiz;
  Future<Helpline> futurehelpline;
  AnimationController _containerController;
  AnimationController _wrongContainerController;
  Animation<Offset> _containerOffsetAnimation;
  Animation<Offset>  _wrongcontainerOffsetAnimation;
  String value= '';
  int points =0;
  int initialindex = 0;
  String peekaboovalue = '';
  List peekaboovalues;
  Color rightColor = Colors.white;
  Color wrongColor = Colors.white;
  Color containercolor = Colors.white;
  GetQuiz getQuizobj = GetQuiz();
  SubmitApi _submitApi = SubmitApi();
  FetchPeekaboo getHelpline = FetchPeekaboo();
  var animationcontroller;
  int tappedindex=-1;
  Submit submitModel;
  List  selectedanswers = new List();
  double beginval = 0.0;
  double endval = 0.0;
  String url = '';
  bool fifty = false;
  int correctanswercount =0;
  int wronganswercount=0;
  String options = '';
  int qsn = 1;
  List option;
  String optionvalue;
  int removecount = 0;
  bool canpeekaboo = true;
  bool canfiftyfifty = true;
  int correctanswer=0;
 bool cantap = true;

  @override
  void initState() {
    super.initState();
    futureQuiz= getQuizobj.fetechquizdata(widget.slug.toString());
    _containerController=AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _containerOffsetAnimation=Tween<Offset>(
      begin: Offset(beginval,0.0),
      end: Offset(endval,0.0),
    ).animate(CurvedAnimation(parent:_containerController,curve: Curves.elasticInOut));

    _wrongContainerController=AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _wrongcontainerOffsetAnimation=Tween<Offset>(
      begin: Offset(0.0,0.0),
      end: Offset(0.0,0.0),
    ).animate(CurvedAnimation(parent:_wrongContainerController,curve: Curves.elasticInOut));


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _containerController.dispose();
    _wrongContainerController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: futureQuiz,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  if(snapshot.data.data.quiz.questions[initialindex].media ==""){
                    url="https://i.ytimg.com/vi/QggJzZdIYPI/mqdefault.jpg";
                  }
                  else{
                    url=snapshot.data.data.quiz.questions[initialindex].media;
                  }

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Questions: ${qsn}/ ${snapshot.data.data.quiz.questions.length}', style: TextStyle(fontSize: 15)),

                            ElevatedButton(

                              child: Text('％', style: TextStyle(fontSize: 20, color: Colors.white),),
                              onPressed: () {
                                if(canfiftyfifty==true){
                                  setState(() {
                                    if(snapshot.data.data.quiz.questions[initialindex].options.length == 4) {
                                      fifty=true;
                                    }

                                    canfiftyfifty=false;
                                  });

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pink,
                                shape:  RoundedRectangleBorder(
                                  borderRadius:  BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              onPressed: ()  async{
                                if(canpeekaboo==true){
                                  var value = await getHelpline.createPeekaboo(snapshot.data.data.quiz.questions[initialindex].id);
                                  peekaboovalues=value.data;
                                  canpeekaboo=false;
                                  setState(() {
                                  });
                                }},
                              label: Text(''),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pink,

                                shape:  RoundedRectangleBorder(
                                  borderRadius:  BorderRadius.circular(10.0),
                                ),
                              ),),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        Container(
                            child: Text('${snapshot.data.data.quiz.questions[initialindex].question}',
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black))),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),


                        Image.network(url),

                        ListView.builder(
                            itemCount: snapshot.data.data.quiz.questions[initialindex].options.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index){
                              if(snapshot.data.data.quiz.questions[initialindex].options[index].isCorrect==true){
                                containercolor= rightColor;
                                animationcontroller= _containerOffsetAnimation;

                              }
                              else if(tappedindex==index){
                                animationcontroller=_wrongcontainerOffsetAnimation;
                                containercolor=wrongColor;
                              }
                              else{
                                animationcontroller= _containerOffsetAnimation;
                                containercolor=Colors.white;

                              }
                              if(peekaboovalues!=null){
                                peekaboovalue="${peekaboovalues[index].percent.toString()}%";
                              }
                              Widget questionoption = Padding(

                                padding:  EdgeInsets.all(10),
                                child: SlideTransition(
                                  position: animationcontroller,
                                  transformHitTests: false,
                                  child: InkWell(
                                    onTap: (){
                                      if(cantap==true){
                                        cantap=false;
                                      removecount=0;


                                      if(snapshot.data.data.quiz.questions.length != qsn){
                                        qsn= qsn +1;
                                      }

                                      Map answers = {'questionId':snapshot.data.data.quiz.questions[initialindex].id,
                                        'answerId':snapshot.data.data.quiz.questions[initialindex].options[index].id};

                                      if( selectedanswers.length==0
                                      ){
                                        //map((x) => Answer.fromJson(x)
                                        selectedanswers =[answers];}
                                      else{
                                        selectedanswers.add(answers);
                                      }

                                      if(snapshot.data.data.quiz.questions[initialindex].options[index].isCorrect==false){
                                        tappedindex=index;
                                        wronganswercount= wronganswercount +1;
                                        wrongColor=Colors.red;
                                        setState(() {
                                          _wrongContainerController=AnimationController(
                                            duration: Duration(milliseconds: 225),
                                            vsync: this,
                                          )..repeat(reverse: false);

                                          _wrongcontainerOffsetAnimation=Tween<Offset>(
                                            begin: Offset(0.01,0.0),
                                            end: Offset(0.0,0.0),
                                          ).animate(CurvedAnimation(parent:_wrongContainerController,curve: Curves.elasticInOut));


                                        });

                                      }
                                      else{
                                        correctanswercount = correctanswercount+1;
                                      }
                                      setState(() {

                                        rightColor=Colors.green;
                                      });}


                                      Future.delayed(const Duration(seconds: 1), () {
                                        cantap=true;
                                        setState(() {
                                          fifty=false;
                                          peekaboovalues= null;
                                          peekaboovalue="";
                                          containercolor=Colors.white;
                                          _wrongcontainerOffsetAnimation=Tween<Offset>(
                                            begin: Offset(0,0.0),
                                            end: Offset(0.0,0.0),
                                          ).animate(CurvedAnimation(parent:_wrongContainerController,curve: Curves.elasticInOut));

                                          rightColor = Colors.white;
                                          wrongColor=Colors.white;

                                          if(initialindex < snapshot.data.data.quiz.questions.length -1){
                                            if(snapshot.data.data.quiz.questions[initialindex].options[index].isCorrect==true){
                                              points = points + snapshot.data.data.quiz.questions[initialindex].options[index].point;
                                              initialindex = initialindex+1;}
                                            else {
                                              points = points - snapshot.data.data.quiz.questions[initialindex].options[index].point;
                                              initialindex = initialindex+1;
                                            }


                                          }
                                          else{
                                            Future.delayed(const Duration(milliseconds:300), () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Welcome(scores: 'Your score is:  ${points + snapshot.data.data.quiz.questions[initialindex].options[index].point}',totalquestions: 'Total Questions: ${snapshot.data.data.quiz.questions.length}', CorrectAnswers: 'Correct Answer: ${correctanswercount}', incorrectanswers: 'IncorrectAnswer: ${wronganswercount}'),)
                                              );


                                              _submitApi.submit(snapshot.data.data.quiz.id,widget.nickname,widget.anonymous,selectedanswers);

                                            });

                                          }
                                        });

                                      });

                                    },
                                    child:  Container(
                                      height: MediaQuery.of(context).size.height*0.1,
                                      width: MediaQuery.of(context).size.width*0.3,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: containercolor,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.black,)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                                        children: [

                                          Text('${snapshot.data.data.quiz.questions[initialindex].options[index].value}',
                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black)),
                                          SizedBox(width: 20,),
                                          Text("${peekaboovalue}"),
                                          //  Text('${snapshot.data.data.rank}'),
                                        ],
                                      ),),
                                  ),
                                ),
                              );

                              if(fifty==true){

                                if(removecount<2){

                                  if(snapshot.data.data.quiz.questions[initialindex].options[index].isCorrect==false){
                                    removecount=removecount+1;
                                    questionoption=Text("");}}

                              }
                              return questionoption;}
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
      ),
    );
  }


}

