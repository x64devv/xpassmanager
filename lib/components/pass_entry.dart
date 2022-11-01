import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpassmanager/components/avatar_card.dart';

import '../screens/constants.dart';
import '../screens/home/components/add_account_sheet.dart';
import 'lottie_widget.dart';

class PassWordEntry extends StatefulWidget {
  const PassWordEntry({
    Key? key,
    required this.avatar,
    required this.name,
    required this.user,
    required this.pass,
  }) : super(key: key);
  final Widget avatar;
  final String name;
  final String user;
  final String pass;

  @override
  State<PassWordEntry> createState() => _PassWordEntryState();
}

class _PassWordEntryState extends State<PassWordEntry> {
  final String obscuredText = "*************";
  String displayText = "*************";
  bool show = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 100,
      padding: const EdgeInsets.only(left: 4, top: 8),
      decoration: BoxDecoration(
          color: kColorAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(32)),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(right: 8, left: 8), child: widget.avatar),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Text(
                widget.name,
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: kColorAccent),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                widget.user,
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: kColorAccent),
              ),
              Row(
                children: [
                  Text(
                    show ? widget.pass : obscuredText,
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: kColorAccent),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        icon: Icon(
                          Icons.visibility_rounded,
                          color: kColorAccent,
                          size: 18,
                        ),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  ],
              ),
            ],
          ),
          const Expanded(
              child: SizedBox(
            width: 4,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.copy_outlined,
                color: kColorAccent,
              ),
              onPressed: () async {
                Clipboard.setData(ClipboardData(text: widget.pass))
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: kColorSecondary,
                              borderRadius: BorderRadius.circular(32)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Password coppied to clipboard!",
                                textAlign: TextAlign.center,
                                style:
                                    textStyle(false, 12, color: kColorPrimary),
                              ),
                              Icon(
                                Icons.check_circle,
                                color: kColorPrimary,
                              )
                            ],
                          ))));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
