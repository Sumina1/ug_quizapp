import 'dart:convert';


import 'package:http/http.dart';
import 'package:ug_quizapp/main.dart';
import 'package:ug_quizapp/model.dart';
import 'package:http/http.dart' as http;
class FetchApi {

  Future<Welcome> fetechdata() async {
    final response =
    await http.get(Uri.parse('https://staging.ugbazaar.com/api/V2/quiz'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = Welcome.fromJson(jsonDecode(response.body));
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ');
    }
  }

}

