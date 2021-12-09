import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ug_quizapp/UI/selectquiz.dart';

class Welcome extends StatefulWidget {
  final scores;
  final CorrectAnswers;
  final rank;
  final incorrectanswers;
  final totalquestions;


  const Welcome({Key key, this.scores, this.CorrectAnswers, this.rank, this.incorrectanswers, this.totalquestions}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  TextEditingController _nicknameController = TextEditingController();
  bool _anonymous = false;
  int score = 0;

  int CorrectAnswers =0;
  int incorrectanswer =0;
  int rant =0;
  int totalquestion=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Padding(
          padding:  EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Nickname: ', style: TextStyle(fontSize: 20, ),),
              SizedBox(height: 10,),
              TextField(
                controller: _nicknameController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)
                  ),

                ),

              ),
              SizedBox(height: 10,),
              SwitchListTile(title: Text('Anonymous: '),
              value: _anonymous,
              onChanged: (bool value){
                setState(() {
                  _anonymous = value;
                });


              },),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectQuiz(anonymous: _anonymous, nickname: _nicknameController.text,)),
                );
                setState(() {
                  _nicknameController.text;
                });
              },
                  child: Text('Start Play')),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Container(

                      child: Text('${widget.totalquestions}')),
                  Container(
                      child: Text(' ${widget.scores}')),
                ],
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(

                      child: Text(' ${widget.CorrectAnswers}')),
                  Container(

                      child: Text(' ${widget.incorrectanswers}')),

                ],
              ),




              
            ],
          ),
        ));
  }
}
