import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpassmanager/components/input_field.dart';
import 'package:xpassmanager/components/x_button.dart';

import '../../../components/avatar_card.dart';
import '../../constants.dart';

class Body extends StatelessWidget {
  String searchText = "";

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
        children: [
          Positioned(
            left: 16,
            right: 16,
            top: 28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                    color: Colors.transparent,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu_rounded,
                          color: kColorPrimary,
                        ))),
                const AvatarCard(
                  image: "assets/avatar_1.jpeg",
                ),
              ],
            ),
          ),
          Positioned(
              top: size.height * 0.15,
              left: 16,
              child: RichText(
                text: TextSpan(
                    text: "Welcome Back!\n\n",
                    style: GoogleFonts.montserrat(fontSize: 12, color: kColorAccent, fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                        text: "Jack Jones",
                        style: GoogleFonts.montserrat(fontSize: 18, color: kColorAccent, fontWeight: FontWeight.bold),
                      )
                    ]),
              )),
          Positioned(
            top: size.height * 0.25,
            right: 16,
            left: 16,
            child: InputField(
                color: kColorPrimary,
                hint: "Search site...",
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return "      Can't search empty value dummy";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  searchText = value;
                },
                icon: Icons.search_rounded),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
                height: size.height * 0.63,
                width: size.width,
                decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Account Cartegory",
                          style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: kColorAccent),
                        ),
                        Icon(
                          Icons.add_box_rounded,
                          color: kColorAccent,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.business_sharp,
                            size: 48,
                            color: kColorSecondary,
                          ),
                          Icon(
                            Icons.sports,
                            size: 48,
                            color: kColorSecondary,
                          ),
                          Icon(
                            Icons.sports_soccer,
                            size: 48,
                            color: kColorSecondary,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Latest",
                      style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: kColorAccent),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(color: kColorAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(32)),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: AvatarCard(image: "assets/avatar_1.jpeg"),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Spotify",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, fontWeight: FontWeight.normal, color: kColorAccent),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "john.doe@x64dev.com",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12, fontWeight: FontWeight.normal, color: kColorAccent),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "************",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12, fontWeight: FontWeight.normal, color: kColorAccent),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.visibility_rounded,
                                        color: kColorAccent,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.copy_outlined,
                              color: kColorAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            bottom: 8,
            right: size.width*0.3,
            left: size.width * 0.3,
            child: XButton(
              text: "Add Account",
              color: kColorAccent,
              textColor: kColorPrimary,
              fontWeight: FontWeight.normal,
              onTap: () {})),
        ],
      ),
    );
  }
}
