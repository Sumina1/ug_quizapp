import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController _nicknameController = TextEditingController();
  bool _anonymous = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Padding(

          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              Text('Your Nickname: ', style: TextStyle(fontSize: 30, ),),
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
                setState(() {
                  _nicknameController.text;
                });



              },
                  child: Text('Start Play')),
              SizedBox(height: 20),
              Text('${_nicknameController.text}')



            ],
          ),
        ));
  }
}
