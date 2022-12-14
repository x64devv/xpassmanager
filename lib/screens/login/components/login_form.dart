import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpassmanager/model/datase_helper.dart';
import 'package:xpassmanager/screens/home/home_screen.dart';

import '../../../components/input_field.dart';
import '../../../components/x_button.dart';
import '../../../model/user_model.dart';
import '../../constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String pass = "";
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "Login",
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: kColorAccent,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            InputField(
              hint: "Enter username",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return "     Please enter a valid username";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                email = value;
              },
              icon: Icons.account_box_rounded,
            ),
            const SizedBox(
              height: 16,
            ),
            InputField(
              hint: "Enter Password",
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              validator: (value) {
                if (!(value.length > 7)) {
                  return "     Password is at least 8 charactors long";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                pass = value;
              },
              icon: Icons.lock_rounded,
            ),
            const SizedBox(
              height: 16,
            ),
            XButton(
              text: 'Login',
              color: kColorAccent,
              textColor: kColorPrimary,
              fontWeight: FontWeight.bold,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      duration: const Duration(seconds: 2, milliseconds: 500),
                      content: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: kColorSecondary,
                              borderRadius: BorderRadius.circular(32)),
                          child: Text(
                            "Verifying user, please wait!",
                            textAlign: TextAlign.center,
                            style: textStyle(false, 12, color: kColorPrimary),
                          ))));
                 fetchUser(email, pass).then((user){
                  if(user.id != 0){
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(user: user,)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          duration:
                              const Duration(seconds: 2, milliseconds: 500),
                          content: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kColorSecondary,
                                  borderRadius: BorderRadius.circular(32)),
                              child: Text(
                                "User not not. Please try again!",
                                textAlign: TextAlign.center,
                                style:
                                    textStyle(false, 12, color: kColorPrimary),
                              ))));
                  }
                 });
                } else {
                  return;
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ));
  }
}
