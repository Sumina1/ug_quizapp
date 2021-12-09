import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ug_quizapp/model/quizesModel.dart';

class FetchApi {
  Future<QuizesModel> fetechdata() async {
    final response =
        await http.get(Uri.parse('https://staging.ugbazaar.com/api/V2/quiz/'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = QuizesModel.fromJson(jsonDecode(response.body));

      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ');
    }
  }
}
