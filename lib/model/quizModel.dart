

import 'package:http/http.dart' as http;

import 'dart:convert';
List questions;
QuizModel QuizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String QuizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  QuizModel({
     this.meta,
    this.data,
    this.message,
  });

   Meta meta;
  Data data;
  String message;

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    meta: Meta.fromJson(json["meta"]),
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.quiz,
    this.recent,
    this.top,
  });

  Quiz quiz;
  List<Recent> recent;
  List<Recent> top;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    quiz: Quiz.fromJson(json["quiz"]),
    recent: List<Recent>.from(json["recent"].map((x) => Recent.fromJson(x))),
    top: List<Recent>.from(json["top"].map((x) => Recent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quiz": quiz.toJson(),
    "recent": List<dynamic>.from(recent.map((x) => x.toJson())),
    "top": List<dynamic>.from(top.map((x) => x.toJson())),
  };
}
class Quiz {
  Quiz({
    this.id,
    this.title,
    this.description,
    this.slug,
    this.thumb,
    this.banner,
    this.limit,
    this.point,
    this.showAnswer,
    this.isPublic,
    this.isActive,
    this.views,
    this.plays,
    this.peekaboo,
    this.fifty50,
    this.user,
    this.created,
    this.questions,
  });

  int id;
  String title;
  String description;
  String slug;
  String thumb;
  String banner;
  int limit;
  int point;
  bool showAnswer;
  bool isPublic;
  bool isActive;
  int views;
  int plays;
  int peekaboo;
  int fifty50;
  User user;
  DateTime created;
  List<Question> questions;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    slug: json["slug"],
    thumb: json["thumb"],
    banner: json["banner"],
    limit: json["limit"],
    point: json["point"],
    showAnswer: json["showAnswer"],
    isPublic: json["is_public"],
    isActive: json["is_active"],
    views: json["views"],
    plays: json["plays"],
    peekaboo: json["peekaboo"],
    fifty50: json["fifty50"],
    user: User.fromJson(json["user"]),
    created: DateTime.parse(json["created"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "slug": slug,
    "thumb": thumb,
    "banner": banner,
    "limit": limit,
    "point": point,
    "showAnswer": showAnswer,
    "is_public": isPublic,
    "is_active": isActive,
    "views": views,
    "plays": plays,
    "peekaboo": peekaboo,
    "fifty50": fifty50,
    "user": user.toJson(),
    "created": "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class Question {
  Question({
    this.id,
    this.question,
    this.type,
    this.point,
    this.media,
    this.caption,
    this.hint,
    this.options,
  });

  int id;
  String question;
  String type;
  int point;
  String media;
  String caption;
  String hint;
  List<Option> options;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    question: json["question"],
    type: json["type"],
    point: json["point"],
    media: json["media"],
    caption: json["caption"],
    hint: json["hint"] == null ? null : json["hint"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "type": type,
    "point": point,
    "media": media,
    "caption": caption,
    "hint": hint == null ? null : hint,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),

  };
}

class Option {
  Option({
    this.id,
    this.value,
    this.isCorrect,
    this.point,
  });

  int id;
  String value;
  bool isCorrect;
  int point;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    value: json["value"],
    isCorrect: json["is_correct"],
    point: json["point"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "is_correct": isCorrect,
    "point": point,
  };
}

class User {
  User({
    this.name,
    this.image,
  });

  String name;
  String image;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
  };
}

class Recent {
  Recent({
    this.id,
    this.name,
    this.username,
    this.image,
    this.score,
    this.played,
  });

  int id;
  String name;
  String username;
  String image;
  int score;
  String played;

  factory Recent.fromJson(Map<String, dynamic> json) => Recent(
    id: json["id"],
    name: json["name"],
    username: json["username"] == null ? null : json["username"],
    image: json["image"],
    score: json["score"],
    played: json["played"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username == null ? null : username,
    "image": image,
    "score": score,
    "played": played,
  };
}

class Meta {
  Meta({
    this.title,
    this.description,
    this.keywords,
    this.image,
  });

  String title;
  String description;
  String keywords;
  String image;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    title: json["title"],
    description: json["description"],
    keywords: json["keywords"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "keywords": keywords,
    "image": image,
  };
}
class GetQuiz{

  Future<QuizModel> fetechquizdata(String slug) async {
    final response =
    await http.get(Uri.parse('https://staging.ugbazaar.com/api/V2/quiz/${slug}'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = QuizModel.fromJson(jsonDecode(response.body));

      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ');

    }


  }



}

