import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xpassmanager/model/cartegory_model.dart';
import 'package:xpassmanager/model/password_model.dart';
import 'package:xpassmanager/model/user_model.dart';

Future<Database> openDb() async {
  WidgetsFlutterBinding.ensureInitialized();
  return await openDatabase(
    join(await getDatabasesPath(), 'pass_manager.db'),
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, username TEXT, password TEXT, avatarPath TEXT)',
      );
      await db.execute(
        'CREATE TABLE account_cartegories(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , cartegoryName TEXT, avatarPath TEXT)',
      );
      await db.execute(
        'CREATE TABLE passwords(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, site TEXT, siteIcon TEXT, user TEXT, pass TEXT, cartegory INTEGER, dateAdded TEXT)',
      );
    },
    version: 1,
  );
}

Future<bool> addUser(UserModel user) async {
  final db = await openDb();
  return await db.insert("users", user.toMap()) > 0;
}

Future<bool> addCartegory(CartegoryModel cartegory) async {
  final db = await openDb();
  return await db.insert("account_cartegories", cartegory.toMap()) > 0;
}

Future<bool> addPassword(PasswordModel password) async {
  final db = await openDb();
  return await db.insert("passwords", password.toMap()) > 0;
}

Future<UserModel> fetchUser(String username, String password) async {
  final db = await openDb();
  List<Map<String, dynamic>> users = await db.query("users",
      where: "username = ? and password = ?", whereArgs: [username, password]);
  return users.isNotEmpty
      ? UserModel(
          id: users[0]["id"],
          name: users[0]["name"],
          username: users[0]["username"],
          password: users[0]["password"],
          avatarPath: users[0]["avatarPath"])
      : UserModel();
}

Future<bool> editUser(UserModel user) async {
  final db = await openDb();
  int successId = await db.update('users', user.toMap(), where: "id = ?", whereArgs: [user.id]);
  return successId > 0;
}

Future<bool> editPassword(PasswordModel password) async {
  final db = await openDb();
  int successId = await db.update('passwords', password.toMap(), where: "id = ?", whereArgs: [password.id]);
  return successId > 0;
}

Future<List<CartegoryModel>> fetchCartegories() async {
  final db = await openDb();
  List<Map<String, dynamic>> cartegories =
      await db.query("account_cartegories");
  return List.generate(
      cartegories.length,
      (index) => CartegoryModel(
          id: cartegories[index]["id"],
          cartegoryName: cartegories[index]["cartegoryName"],
          avatarPath: cartegories[index]["avatarPath"]));
}

Future<List<PasswordModel>> fetchPasswords() async {
  final db = await openDb();
  List<Map<String, dynamic>> passwords = await db.query("passwords");

  return List.generate(
      passwords.length,
      (index) => PasswordModel(
            id: passwords[index]["id"],
            name: passwords[index]["name"],
            siteIcon: passwords[index]["siteIcon"],
            site: passwords[index]["site"],
            user: passwords[index]["user"],
            pass: passwords[index]["pass"],
            cartegory: passwords[index]["cartegory"],
            dateAdded: passwords[index]["dateAdded"],
          ));
}

Future<List<PasswordModel>> searchPasswordWithId(int id) async {
  final db = await openDb();
  List<Map<String, dynamic>> passwords =
      await db.query("passwords", where: "cartegory = ?", whereArgs: [id]);

  return List.generate(
      passwords.length,
      (index) => PasswordModel(
            id: passwords[index]["id"],
            name: passwords[index]["name"],
            siteIcon: passwords[index]["siteIcon"],
            site: passwords[index]["site"],
            user: passwords[index]["user"],
            pass: passwords[index]["pass"],
            cartegory: passwords[index]["cartegory"],
            dateAdded: passwords[index]["dateAdded"],
          ));
}

Future<List<PasswordModel>> searchPasswordWithMatch(String q) async {
  final db = await openDb();
  List<Map<String, dynamic>> passwords = await db.query("passwords",
      where: "name LIKE ? OR site LIKE ?  OR user LIKE ?",
      whereArgs: ["%$q%", "%$q%", "%$q%"]);

  return List.generate(
      passwords.length,
      (index) => PasswordModel(
            id: passwords[index]["id"],
            name: passwords[index]["name"],
            siteIcon: passwords[index]["siteIcon"],
            site: passwords[index]["site"],
            user: passwords[index]["user"],
            pass: passwords[index]["pass"],
            cartegory: passwords[index]["cartegory"],
            dateAdded: passwords[index]["dateAdded"],
          ));
}
