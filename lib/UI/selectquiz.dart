

import 'package:flutter/material.dart';
import 'package:ug_quizapp/DataFetch/fetechapi.dart';
import 'package:ug_quizapp/UI/startquiz.dart';

class SelectQuiz extends StatefulWidget {
  final  nickname;
  final  anonymous;

  const SelectQuiz({Key key, this.nickname, this.anonymous}) : super(key: key);



  @override
  _SelectQuizState createState() => _SelectQuizState();
}

class _SelectQuizState extends State<SelectQuiz> {
  FetchApi obj = FetchApi();
  Color rgba =  Color(0xFF42A5F5);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: obj.fetechdata(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data.data.all.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StartQuiz(slug: snapshot.data.data.all[index].slug,  anonymous: widget.anonymous, nickname: widget.nickname,)),
                          );
                        },
                        child: Container( height: MediaQuery.of(context).size.height*0.1,
                            width: MediaQuery.of(context).size.width*0.1,
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(
                                  color: Colors.grey.withOpacity(0.3), //color of shadow
                                  spreadRadius: 5, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(0, 2), // changes position of shadow
                                )],
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                         // color: Color(int.parse(snapshot.data.data.banner.backgroundColor

                            child: Center(child: Text('${snapshot.data.data.all[index].name}',)))

                      );


                  }


              );
            }
            else {
              return CircularProgressIndicator();
            }
          }


      ),
    );
  }
}
