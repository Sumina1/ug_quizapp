
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:ug_quizapp/UI/welcome.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body:   Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text('Please login to play quiz!', style:TextStyle(fontSize: 20),),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),

              Container(
                height: MediaQuery.of(context).size.height*0.06,


                child: SignInButtonBuilder(
                  text: 'Login To Play',
                  icon: Icons.person,
                  onPressed: () {},
                  backgroundColor: Colors.pink,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),

              Container(
                height: MediaQuery.of(context).size.height*0.06,

                child: SignInButtonBuilder(
                  text: 'Login with Facebook',
                  icon: Icons.facebook,
                  onPressed: () {},
                  backgroundColor: Colors.blue,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),

              Container(
                height: MediaQuery.of(context).size.height*0.06,

                decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(50)
                    )
                ),
                child: ElevatedButton(
                  child: Text('Skip Login', style: TextStyle(color: Colors.pink),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Welcome(scores: '', incorrectanswers: '', CorrectAnswers: '',totalquestions: '',rank: '',)),
                    );

                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)
                  ),


                ),
              ),


]
    ),
        )
    );
  }
}