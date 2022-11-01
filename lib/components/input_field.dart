import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/constants.dart';

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    this.obscureText = false,
    this.color = Colors.transparent,
    this.fontSize = 16,
    required this.hint,
    required this.keyboardType,
    required this.validator,
    required this.onChanged,
    required this.icon,
    this.text = "",
  }) : super(key: key);
  final String hint;
  final TextInputType keyboardType;
  final String? Function(dynamic)  validator;
  final ValueChanged onChanged;
  final IconData icon;
  String text;
  bool obscureText;
  Color color;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: kColorAccent.withOpacity(0.8)),
      ),
      child: Material(
        color: Colors.transparent,
        child: TextFormField(
          initialValue: text,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscureText,
          style:
              GoogleFonts.montserrat(fontSize: fontSize, color: kColorAccent),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: GoogleFonts.montserrat(
                  fontSize: fontSize, color: kColorAccent.withOpacity(0.8)),
              prefixIcon: Icon(
                icon,
                color: kColorAccent,
                size: 18,
              )),
        ),
      ),
    );
  }
}
