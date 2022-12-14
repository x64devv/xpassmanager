import 'package:xpassmanager/components/avatar_card.dart';

class UserModel {
  int? id;
  String? name;
  String? username;
  String? password;
  String? avatarPath;

  UserModel(
      {this.id = 0,
      this.name = "",
      this.username = "",
      this.password = "",
      this.avatarPath = "assets/avatar_1.jpeg"});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "username": username,
      "password": password,
      "avatarPath": avatarPath,
    };
  }
}
