import 'package:flutter/material.dart';
import 'package:xpassmanager/model/user_model.dart';
import 'package:xpassmanager/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.user});
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(user : user),
    );
  }
}
