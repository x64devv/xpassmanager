import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/constants.dart';


class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 200,
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: kColorPrimary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: kColorAccent, offset: const Offset(1, 2), spreadRadius: 1, blurRadius: 8)],
            ),
            child: Center(
              child: Text(
                "X",
                style: GoogleFonts.montserrat(color: kColorSecondary, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: GoogleFonts.montserrat(color: kColorAccent, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Manager",
                  style: GoogleFonts.montserrat(color: kColorAccent, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
