import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/constants.dart';

class SearchField extends StatelessWidget {
  SearchField({
    super.key,
    required this.searchFxn,
  });
  Function(String) searchFxn;
  String text = "";
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: kColorPrimary,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: kColorAccent.withOpacity(0.8)),
        ),
        child: Material(
          color: Colors.transparent,
          child: Form(
            key: _key,
            child: TextFormField(
              initialValue: text,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return "            Can't search an empty value dummy!";
                }
                return null;
              },
              onChanged: (value) {
                text = value;
              },
              style: GoogleFonts.montserrat(fontSize: 12, color: kColorAccent),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search...",
                  hintStyle: GoogleFonts.montserrat(
                      fontSize: 12, color: kColorAccent.withOpacity(0.8)),
                  prefixIcon: IconButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          searchFxn(text);
                        }
                      },
                      icon: Icon(
                        Icons.search_rounded,
                        color: kColorAccent,
                      ))),
            ),
          ),
        ));
  }
}
