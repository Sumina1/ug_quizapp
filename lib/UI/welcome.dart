import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ug_quizapp/UI/selectquiz.dart';

class Welcome extends StatefulWidget {
  final scores;

  const Welcome({Key key, this.scores}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  TextEditingController _nicknameController = TextEditingController();
  bool _anonymous = false;
  int score = 0;
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

              Container(

                  child: Text(' ${widget.scores}')),








            ],
          ),
        ));
  }
}
