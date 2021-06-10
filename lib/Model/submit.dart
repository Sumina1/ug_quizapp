// To parse this JSON data, do
//
//     final submit = submitFromJson(jsonString);
import 'package:http/http.dart' as http;

import 'dart:convert';

Submit submitFromJson(String str) => Submit.fromJson(json.decode(str));

String submitToJson(Submit data) => json.encode(data.toJson());

class Submit {
  Submit({
    this.quizId,
    this.nickname,
    this.anonymous,
    this.answers,
  });

  int quizId;
  String nickname;
  bool anonymous;
  List<Answer> answers;

  factory Submit.fromJson(Map<String, dynamic> json) => Submit(
    quizId: json["quizId"],
    nickname: json["nickname"],
    anonymous: json["anonymous"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quizId": quizId,
    "nickname": nickname,
    "anonymous": anonymous,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    this.questionId,
    this.answerId,
  });

  int questionId;
  int answerId;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    questionId: json["questionId"],
    answerId: json["answerId"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "answerId": answerId,
  };
}
class SubmitApi {
  Future<Submit> submit(int quizId, String nickname, bool anonymous,
      List answers) async {
    var response = await http.post(
        Uri.parse("https://staging.ugbazaar.com/api/V2/quiz/submit"),
        headers: {
          "content-type": "application/json",
        },

        body: jsonEncode({
          "quizId": quizId,
          "nickname": nickname,
          "anonymous": anonymous,
          "answers": answers,
        }));



    if (response.statusCode == 200) {
      print('done');

    }
    else {
      throw Exception('Failed to create helpline.');
    }
  }
}