import 'dart:convert';

Data qFromJson(String str) => Data.fromJson(json.decode(str));

String qToJson(Data data) => json.encode(data.toJson());

class Data {
  int id;
  String email;
  String date;
  String questionnaire;
  String answers;

  Data({
    this.id,
    this.email,
    this.questionnaire,
    this.date,
    this.answers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        questionnaire: json["questionnaire"],
        date: json["date"],
        answers: json["answers"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "questionnaire": questionnaire,
        "date": date,
        "answers": answers, //.toJson(),
      };
}
