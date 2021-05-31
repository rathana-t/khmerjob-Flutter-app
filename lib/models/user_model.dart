// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
    User({
        this.users,
    });

    List<UserElement> users;

    factory User.fromMap(Map<String, dynamic> json) => User(
        users: List<UserElement>.from(json["users"].map((x) => UserElement.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "users": List<dynamic>.from(users.map((x) => x.toMap())),
    };
}

class UserElement {
    UserElement({
        this.id,
        this.username,
        this.gender,
        this.phone,
        this.email,
        this.dob,
        this.imgProfile,
        this.password,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    String username;
    String gender;
    String phone;
    String email;
    String dob;
    dynamic imgProfile;
    String password;
    dynamic createdAt;
    dynamic updatedAt;

    factory UserElement.fromMap(Map<String, dynamic> json) => UserElement(
        id: json["id"],
        username: json["username"],
        gender: json["gender"],
        phone: json["phone"],
        email: json["email"],
        dob: json["DOB"],
        imgProfile: json["imgProfile"],
        password: json["password"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "gender": gender,
        "phone": phone,
        "email": email,
        "DOB": dob,
        "imgProfile": imgProfile,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
