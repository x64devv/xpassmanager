import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpassmanager/screens/constants.dart';

class XButton extends StatelessWidget {
  const XButton({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.fontWeight, required this.onTap,
  }) : super(key: key);
  final String text;
  final Color color;
  final Color textColor;
  final FontWeight fontWeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(32),
        color: Colors.transparent,
        child: InkWell(
          splashColor: kColorSecondary,
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.montserrat(fontSize: 16, fontWeight: fontWeight, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
