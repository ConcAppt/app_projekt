import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String name;
  int age;
  String email;
  String password;

  User({
    this.name,
    this.age,
    this.email,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        age: json["age"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "email": email,
        "password": password,
      };
}
