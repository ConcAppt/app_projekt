import 'dart:convert';

Data erqFromJson(String str) => Data.fromJson(json.decode(str));

String erqToJson(Data data) => json.encode(data.toJson());

class Data {
  String email;
  String questionnaire;
  String date;
  int value;

  Data({
    this.email,
    this.questionnaire,
    this.date,
    this.value
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
    questionnaire: json["questionnaire"],
    date: json["date"],
    value: json["value"]
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "questionnaire": questionnaire,
    "date": date,
    "value": value
  };
}