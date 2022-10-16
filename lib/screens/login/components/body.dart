import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpassmanager/screens/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:xpassmanager/screens/login/components/login_form.dart';

import '../../../components/input_field.dart';
import '../../../components/logo.dart';
import '../../../components/lottie_widget.dart';
import '../../../components/social_card.dart';

class Body extends StatelessWidget {
  Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: kColorSecondary,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 20,
            left: (size.width / 2) - 90,
            child: const Logo(),
          ),
          Positioned(
            top: size.height * 0.15,
            left: (size.width / 2) - (size.width * 0.3),
            child: LottieWidget(
              lottieAnimation: "assets/lottie/lottie_login.json",
              size: size,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * 0.55,
              width: size.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kColorPrimary,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const LoginForm(),
                    Text(
                      "OR",
                      style: GoogleFonts.montserrat(fontSize: 11, color: kColorAccent, fontWeight: FontWeight.normal),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SocialMediaCard(icon: const Icon(Icons.facebook_rounded), onPressed: () {}),
                    //       SocialMediaCard(icon: const Icon(Icons.bubble_chart), onPressed: () {}),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextButton(onPressed: () {}, child: Text(
                        "No Accout? Register Here",
                        style: GoogleFonts.montserrat(fontSize: 11, color: kColorAccent, decoration: TextDecoration.underline, fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
