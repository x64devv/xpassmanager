import 'dart:io';

import 'package:flutter/material.dart';

import '../screens/constants.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    bool isAsset = image.contains("assets");
    return Container(
      // margin: const EdgeInsets.only(right: 16),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        image: isAsset
            ? DecorationImage(image: AssetImage(image), fit: BoxFit.cover)
            : DecorationImage(image: FileImage(File(image)), fit: BoxFit.cover),
        border: Border.all(color: kColorPrimary),
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
