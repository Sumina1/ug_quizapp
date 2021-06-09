
import 'package:flutter/material.dart';
import 'package:ug_quizapp/Model/helpline.dart';
import 'package:ug_quizapp/Model/quizModel.dart';


class StartQuiz extends StatefulWidget {
  final slug;

  const StartQuiz({Key key, this.slug}) : super(key: key);
  @override
  _StartQuizState createState() => _StartQuizState();

}
class _StartQuizState extends State<StartQuiz> with TickerProviderStateMixin{
   Future<QuizModel> futureQuiz;
   Future<Helpline> futurehelpline;
   AnimationController _containerController;
   Animation<Offset> _containerOffsetAnimation;
  String value= '';
  int points =0;
  int initialindex = 0;
  String peekaboovalue = '';
  List peekaboovalues;
  Color rightColor = Colors.white;
  Color wrongColor = Colors.white;
  Color containercolor = Colors.white;
  GetQuiz getQuizobj = GetQuiz();
   FetchPeekaboo getHelpline = FetchPeekaboo();
   double animationval = 0.0;
   int tappedindex=-1;
  @override
  void initState() {
    super.initState();

    futureQuiz= getQuizobj.fetechquizdata(widget.slug.toString());


    _containerController=AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _containerOffsetAnimation=Tween<Offset>(
      begin: Offset(animationval,0),
      end: Offset(0,0.0),
    ).animate(CurvedAnimation(parent:_containerController,curve: Curves.elasticInOut));

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _containerController.dispose();
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
                            if (snapshot.hasData) {
                              _containerController.forward();
                            }
                            if(snapshot.data.data.quiz.questions[initialindex].options[index].isCorrect==true){
                              print(snapshot.data.data.quiz.questions[initialindex].options[index].isCorrect);
                              containercolor= rightColor;
                            }
                            else if(tappedindex==index){

                              containercolor=wrongColor;
                            }
                            else{
                              containercolor=Colors.white;
                            }
                            if(peekaboovalues!=null){
                              peekaboovalue="${peekaboovalues[index].percent.toString()}%";
                            }

                            return Padding(
                              padding:  EdgeInsets.all(10),
                              child: SlideTransition(
                                position: _containerOffsetAnimation,
                                child: InkWell(
                                  onTap: (){
                                    if(snapshot.data.data.quiz.questions[initialindex].options[index].isCorrect==false){
                                      tappedindex=index;
                                      wrongColor=Colors.red;
                                    }
                                    setState(() {
                                      rightColor = Colors.green;

                                    });

                                    Future.delayed(const Duration(seconds: 2), () {
                                      setState(() {
                                        containercolor=Colors.white;
                                        rightColor = Colors.white;
                                        wrongColor=Colors.white;
                                        if(initialindex < snapshot.data.data.quiz.questions.length -1){
                                          if(snapshot.data.data.quiz.questions[initialindex].options[index].isCorrect==true){
                                            points = points + snapshot.data.data.quiz.questions[initialindex].options[index].point;
                                            initialindex = initialindex+1;}
                                          else {
                                            points = points - snapshot.data.data.quiz.questions[initialindex].options[index].point;
                                            initialindex = initialindex+1;
                                          }   }

                                      });

                                    });

                                  },

                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.1,
                                    width: MediaQuery.of(context).size.width*0.2,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: containercolor,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: Colors.black,)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                                      children: [
                                        Text('${snapshot.data.data.quiz.questions[initialindex].options[index].value}',
                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                                        SizedBox(width: 20,),
                                        Text("${peekaboovalue}")
                                      ],
                                    ),),
                                ),
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

