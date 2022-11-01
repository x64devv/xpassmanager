import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/constants.dart';


class AccountCartegory extends StatelessWidget {
  const AccountCartegory({
    Key? key,
    required this.cartegory,
    required this.icon,
  }) : super(key: key);
  final String cartegory;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Center(
          child: Column(
        children: [
          icon,
          Text(
            cartegory,
            style: GoogleFonts.montserrat(
                color: kColorAccent,
                fontSize: 12,
                fontWeight: FontWeight.normal),
          )
        ],
      )),
    );
  }
}
