

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.meta,
    this.data,
    this.message,
  });

  Meta meta;
  Data data;
  String message;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
    this.banner,
    this.all,
    this.dataNew,
    this.mostPlayed,
  });

  Banner banner;
  List<All> all;
  List<All> dataNew;
  List<All> mostPlayed;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    banner: Banner.fromJson(json["banner"]),
    all: List<All>.from(json["all"].map((x) => All.fromJson(x))),
    dataNew: List<All>.from(json["new"].map((x) => All.fromJson(x))),
    mostPlayed: List<All>.from(json["mostPlayed"].map((x) => All.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banner": banner.toJson(),
    "all": List<dynamic>.from(all.map((x) => x.toJson())),
    "new": List<dynamic>.from(dataNew.map((x) => x.toJson())),
    "mostPlayed": List<dynamic>.from(mostPlayed.map((x) => x.toJson())),
  };
}

class All {
  All({
    this.id,
    this.slug,
    this.name,
    this.description,
    this.public,
    this.active,
    this.questions,
    this.plays,
    this.views,
    this.thumb,
    this.banner,
    this.user,
    this.created,
  });

  int id;
  String slug;
  String name;
  String description;
  bool public;
  bool active;
  int questions;
  int plays;
  int views;
  String thumb;
  String banner;
  User user;
  DateTime created;

  factory All.fromJson(Map<String, dynamic> json) => All(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    description: json["description"] == null ? null : json["description"],
    public: json["public"],
    active: json["active"],
    questions: json["questions"],
    plays: json["plays"],
    views: json["views"],
    thumb: json["thumb"],
    banner: json["banner"],
    user: User.fromJson(json["user"]),
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "description": description == null ? null : description,
    "public": public,
    "active": active,
    "questions": questions,
    "plays": plays,
    "views": views,
    "thumb": thumb,
    "banner": banner,
    "user": user.toJson(),
    "created": "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
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

class Banner {
  Banner({
    this.backgroundColor,
    this.textColor,
    this.backgroundImage,
    this.backgroundImageMobile,
    this.title,
    this.subtitle,
  });

  String backgroundColor;
  String textColor;
  String backgroundImage;
  String backgroundImageMobile;
  String title;
  String subtitle;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    backgroundColor: json["backgroundColor"],
    textColor: json["textColor"],
    backgroundImage: json["backgroundImage"],
    backgroundImageMobile: json["backgroundImageMobile"],
    title: json["title"],
    subtitle: json["subtitle"],
  );

  Map<String, dynamic> toJson() => {
    "backgroundColor": backgroundColor,
    "textColor": textColor,
    "backgroundImage": backgroundImage,
    "backgroundImageMobile": backgroundImageMobile,
    "title": title,
    "subtitle": subtitle,
  };
}

class Meta {
  Meta({
    this.title,
    this.keywords,
    this.description,
    this.image,
    this.pagination,
  });

  String title;
  String keywords;
  String description;
  String image;
  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    title: json["title"],
    keywords: json["keywords"],
    description: json["description"],
    image: json["image"],
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "keywords": keywords,
    "description": description,
    "image": image,
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  Pagination({
    this.lastPage,
    this.perPage,
    this.total,
  });

  int lastPage;
  int perPage;
  int total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    lastPage: json["lastPage"],
    perPage: json["perPage"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "lastPage": lastPage,
    "perPage": perPage,
    "total": total,
  };
}

