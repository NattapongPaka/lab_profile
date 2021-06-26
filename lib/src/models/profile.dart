// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

class Profile {
  Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.birthDay,
    this.address,
    this.gender,
    this.phone,
    this.email,
    this.age,
    this.company,
    this.picture,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String birthDay;
  final String address;
  final String gender;
  final String phone;
  final String email;
  final String age;
  final String company;
  final String picture;

  Profile copyWith({
    int id,
    String firstName,
    String lastName,
    String birthDay,
    String address,
    String gender,
    String phone,
    String email,
    String age,
    String company,
    String picture,
  }) =>
      Profile(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        birthDay: birthDay ?? this.birthDay,
        address: address ?? this.address,
        gender: gender ?? this.gender,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        age: age ?? this.age,
        company: company ?? this.company,
        picture: picture ?? this.picture,
      );

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        birthDay: json["birth_day"] == null ? null : json["birth_day"],
        address: json["address"] == null ? null : json["address"],
        gender: json["gender"] == null ? null : json["gender"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        age: json["age"] == null ? null : json["age"],
        company: json["company"] == null ? null : json["company"],
        picture: json["picture"] == null ? null : json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "birth_day": birthDay == null ? null : birthDay,
        "address": address == null ? null : address,
        "gender": gender == null ? null : gender,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "age": age == null ? null : age,
        "company": company == null ? null : company,
        "picture": picture == null ? null : picture,
      };
}
