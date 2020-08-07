import 'dart:convert';

Data erqFromJson(String str) => Data.fromJson(json.decode(str));

String erqToJson(Data data) => json.encode(data.toJson());

class Data {
  String email;
  String date;
  int value;

  Data({
    this.email,
    this.date,
    this.value
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
    date: json["date"],
    value: json["value"]
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "date": date,
    "value": value
  };
}