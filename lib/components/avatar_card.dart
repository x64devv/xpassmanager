import 'package:flutter/material.dart';

import '../screens/constants.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(right: 16),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image)),
        border: Border.all(color: kColorPrimary),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
