

import 'package:http/http.dart' as http;

import 'dart:convert';


Helpline HelplineFromJson(String str) => Helpline.fromJson(json.decode(str));

String HelplineToJson(Helpline data) => json.encode(data.toJson());

class Helpline {
  Helpline({
    this.meta,
    this.data,
    this.message,
  });

  Meta meta;
  List<Datum> data;
  String message;

  factory Helpline.fromJson(Map<String, dynamic> json) => Helpline(
    meta: Meta.fromJson(json["meta"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  Datum({
    this.id,
    this.value,
    this.count,
    this.percent,
  });

  int id;
  String value;
  int count;
  int percent;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    value: json["value"],
    count: json["count"],
    percent: json["percent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "count": count,
    "percent": percent,
  };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
  );

  Map<String, dynamic> toJson() => {
  };
}
class FetchPeekaboo {
  Future<Helpline> createPeekaboo(int id) async {
var Url = Uri.parse('https://staging.ugbazaar.com/api/V2/quiz/${id}/peekaboo');
    //http.Response response = await http.get(url);
     http.Response response = await http.post(Url);
      response.statusCode;
    if (response.statusCode == 200) {

      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Helpline.fromJson(jsonDecode(response.body));

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create helpline.');
    }
  }
}




