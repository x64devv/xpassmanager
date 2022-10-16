import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpassmanager/screens/home/home_screen.dart';

import '../../../components/input_field.dart';
import '../../../components/x_button.dart';
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
              style: GoogleFonts.montserrat(fontSize: 20, color: kColorAccent, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            InputField(
              hint: "Enter Email",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (!EmailValidator.validate(value)) {
                  return "     Please enter a valid email";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                email = value;
              },
              icon: Icons.mail_outline,
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
              icon: Icons.mail_outline,
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
                  Get.to(HomeScreen(), transition: Transition.leftToRightWithFade, duration: Duration(seconds: 1));
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
