import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpassmanager/model/datase_helper.dart';
import 'package:xpassmanager/model/user_model.dart';
import 'package:xpassmanager/screens/login/login_screen.dart';

import '../../../components/input_field.dart';
import '../../../components/x_button.dart';
import '../../constants.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  var _formKey = GlobalKey<FormState>();
  UserModel user = UserModel();

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
              hint: "Enter your name",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return "     Please enter a valid name";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                user.name = value;
              },
              icon: Icons.account_box_rounded,
            ),
            const SizedBox(
              height: 16,
            ),
            InputField(
              hint: "Enter your username",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return "     Please enter a valid username";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                user.username = value;
              },
              icon: Icons.short_text,
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
                user.password = value;
              },
              icon: Icons.lock_rounded,
            ),
            const SizedBox(
              height: 16,
            ),
            InputField(
              hint: "Confirm Password",
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              validator: (value) {
                if (value != user.password) {
                  return "     Passwords don't match!";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                user.password = value;
              },
              icon: Icons.lock_rounded,
            ),
            const SizedBox(
              height: 16,
            ),
            XButton(
              text: 'Register',
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
                            "Registering ${user.name}, please wait!",
                            textAlign: TextAlign.center,
                            style: textStyle(false, 12, color: kColorPrimary),
                          ))));
                  addUser(user).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        duration: const Duration(seconds: 2),
                        content: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: kColorSecondary,
                                borderRadius: BorderRadius.circular(32)),
                            child: Text(
                              value
                                  ? "${user.name} added successfully."
                                  : "${user.name} adding failded!. Try again",
                              textAlign: TextAlign.center,
                              style: textStyle(false, 12, color: kColorPrimary),
                            ))));
                    if (value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }
                  });
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
