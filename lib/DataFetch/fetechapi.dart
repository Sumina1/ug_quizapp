import 'dart:convert';
import 'dart:html';



import 'package:ug_quizapp/Model/quizesModel.dart';
import 'package:http/http.dart' as http;
class FetchApi {

  Future<Welcome> fetechdata() async {
    final response =
    await http.get(Uri.parse('https://staging.ugbazaar.com/api/V2/quiz/'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = Welcome.fromJson(jsonDecode(response.body));
      print(data.data.all[0].name);
      print(data.data.banner.backgroundColor);

      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ');
    }
  }






}

