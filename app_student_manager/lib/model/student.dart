import 'dart:convert';
import 'dart:core';
import 'dart:ffi';

Student studentJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Long {
  final int value;

  Long(this.value);
}

class Student {
  Long id;
  String name;
  String phone;
  String email;
  int age;
  String sex;
  String address;

  Student(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.sex,
      required this.age,
      required this.address});


  factory Student.fromJson(Map<String, dynamic> json) => Student(
      id: Long(json["id"]),
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      sex: json["sex"],
      age: json["age"],
      address: json["address"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "sex": sex,
        "age": age,
        "address": address
      };
}
